import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'live_price_indicator.dart';

class ClassicRateCard extends StatefulWidget {
  final String title;
  final String value;
  final String? value2;
  final String highLow;

  const ClassicRateCard({
    super.key,
    required this.title,
    required this.value,
    this.value2,
    required this.highLow,
  });

  @override
  State<ClassicRateCard> createState() => _ClassicRateCardState();
}

class _ClassicRateCardState extends State<ClassicRateCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  Timer? _delayTimer;
  PriceStatus _status = PriceStatus.none;
  double? _oldPrice;

  @override
  void initState() {
    super.initState();
    _oldPrice = double.tryParse(widget.value.replaceAll(',', ''));
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _colorAnimation = ColorTween(
      begin: AppColors.primaryLight,
      end: AppColors.primaryLight,
    ).animate(_controller);
  }

  void _setupAnimation(Color flashColor) {
    _colorAnimation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: AppColors.primaryLight, end: flashColor),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: ConstantTween<Color?>(flashColor),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: flashColor, end: AppColors.primaryLight),
        weight: 35,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(ClassicRateCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      final newPrice = double.tryParse(widget.value.replaceAll(',', ''));
      _delayTimer?.cancel();
      _controller.stop();
      _controller.value = 0.0;

      if (newPrice != null && _oldPrice != null && newPrice != _oldPrice) {
        final currentStatus = newPrice > _oldPrice! ? PriceStatus.profit : PriceStatus.loss;
        
        _delayTimer = Timer(const Duration(seconds: 2), () {
          if (!mounted) return;
          setState(() {
            _status = currentStatus;
            final flashColor = _status == PriceStatus.profit 
                ? const Color(0xA552F30C).withValues(alpha: 0.4) // Subtle full card flash
                : const Color(0xD0FF0505).withValues(alpha: 0.4);
            _setupAnimation(flashColor);
            _controller.forward(from: 0.0);
          });
        });
      }
      _oldPrice = newPrice;
    }
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
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white10),
            boxShadow: _status != PriceStatus.none && _controller.isAnimating && _controller.value > 0.1 && _controller.value < 0.7
                ? [
                    BoxShadow(
                      color: (_status == PriceStatus.profit ? const Color(0xA552F30C) : const Color(0xD0FF0505)).withValues(alpha: 0.2),
                      blurRadius: 20,
                      spreadRadius: 3,
                    )
                  ]
                : [],
          ),
          child: Column(
            children: [
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LivePriceIndicator(
                      price: widget.value,
                      style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      showArrow: false,
                    ),
                    if (widget.value2 != null) ...[
                      const SizedBox(width: 4),
                      LivePriceIndicator(
                        price: widget.value2!,
                        style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        showArrow: false,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.highLow,
                style: const TextStyle(color: Colors.white70, fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
