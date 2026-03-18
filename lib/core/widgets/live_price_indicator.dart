import 'dart:async';
import 'package:flutter/material.dart';

enum PriceStatus { none, profit, loss }

class LivePriceIndicator extends StatefulWidget {
  final String price;
  final TextStyle style;
  final TextAlign textAlign;
  final bool showArrow;
  final bool showShadow;
  final bool showBackground;

  const LivePriceIndicator({
    super.key,
    required this.price,
    required this.style,
    this.textAlign = TextAlign.right,
    this.showArrow = true,
    this.showShadow = true,
    this.showBackground = true,
  });

  @override
  State<LivePriceIndicator> createState() => _LivePriceIndicatorState();
}

class _LivePriceIndicatorState extends State<LivePriceIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _scaleAnimation;
  
  PriceStatus _status = PriceStatus.none;
  double? _oldPrice;
  late String _displayPrice;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _displayPrice = widget.price;
    _oldPrice = double.tryParse(widget.price.replaceAll(',', ''));
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000), // Adjusted for Fade-in/Stay/Fade-out
    );

    _setupAnimations(Colors.transparent);
  }

  void _setupAnimations(Color highlightColor) {
    _colorAnimation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.transparent, end: highlightColor),
        weight: 15, // Fade-in (300ms)
      ),
      TweenSequenceItem(
        tween: ConstantTween<Color?>(highlightColor),
        weight: 50, // Stay (1000ms)
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: highlightColor, end: Colors.transparent),
        weight: 35, // Fade-out (700ms)
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 15), // No scale during delay/fade-in start
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 65),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(LivePriceIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.price != widget.price) {
      final newPrice = double.tryParse(widget.price.replaceAll(',', ''));
      
      // Cancel previous timer and animation if a new update arrives
      _delayTimer?.cancel();
      _controller.stop();
      _controller.value = 0.0;
      
      if (newPrice != null && _oldPrice != null && newPrice != _oldPrice) {
        final currentProfitStatus = newPrice > _oldPrice! ? PriceStatus.profit : PriceStatus.loss;
        
        setState(() {
          _status = currentProfitStatus;
        });

        final color = _status == PriceStatus.profit 
            ? const Color(0xFF00C853) // Vibrant Green
            : const Color(0xFFFF0000); // Vibrant Red
            
        _triggerAnimation(color);
      }
      
      _oldPrice = newPrice;
      _displayPrice = widget.price;
    }
  }

  void _triggerAnimation(Color color) {
    _setupAnimations(color);
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: widget.showBackground ? BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(6),
            boxShadow: widget.showShadow && _status != PriceStatus.none && _controller.isAnimating && _controller.value > 0.05 && _controller.value < 0.85
                ? [
                    BoxShadow(
                      color: (_status == PriceStatus.profit ? const Color(0xFF00C853) : const Color(0xFFFF0000)).withValues(alpha: 0.4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ) : null,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: widget.textAlign == TextAlign.right ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (widget.showArrow && _status != PriceStatus.none && _controller.isAnimating)
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Icon(
                        _status == PriceStatus.profit ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.white,
                        size: widget.style.fontSize != null ? widget.style.fontSize! * 0.9 : 18,
                      ),
                    ),
                  Text(
                    _displayPrice,
                    style: widget.style.copyWith(
                      color: (_status != PriceStatus.none && _controller.isAnimating && _controller.value > 0.05) 
                        ? Colors.white 
                        : widget.style.color,
                    ),
                    textAlign: widget.textAlign,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
