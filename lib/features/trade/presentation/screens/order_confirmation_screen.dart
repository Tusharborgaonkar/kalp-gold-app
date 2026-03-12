import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/constants.dart';
import 'order_success_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> tradeDetails;
  
  const OrderConfirmationScreen({super.key, required this.tradeDetails});

  @override
  Widget build(BuildContext context) {
    final metalGradient = tradeDetails['isGold'] ? AppColors.goldGradient : AppColors.silverGradient;
    final metalAccent = tradeDetails['isGold'] ? AppColors.gold : AppColors.silver;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Confirm Purchase', 
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w900, letterSpacing: 1)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
                ],
              ),
              child: Column(
                children: [
                  _row('Asset', tradeDetails['asset']),
                  _divider(),
                  _row('Quantity', '${tradeDetails['quantity']}g'),
                  _divider(),
                  _row('Price', '₹${tradeDetails['price']}'),
                  _divider(),
                  _row('Total', '₹${tradeDetails['total']}', isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.silverLight),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary),
                  const SizedBox(width: 12),
                  const Text('Payment Method', 
                      style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                  const Spacer(),
                  const Text('Wallet Balance', 
                      style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                ],
              ),
            ),
            const Spacer(),
            _SwipeToConfirm(
              onConfirm: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OrderSuccessScreen(tradeDetails: tradeDetails)),
                );
              },
              label: 'Swipe to Confirm',
              accentColor: metalAccent,
              accentGradient: metalGradient,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w800,
            fontSize: isBold ? 18 : 15,
            color: AppColors.textPrimary,
          )),
        ],
      ),
    );
  }

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Divider(height: 1, color: AppColors.silverLight),
  );
}

// Re-using Swipe to Confirm widget structure (simplified for brevity)
class _SwipeToConfirm extends StatefulWidget {
  final VoidCallback onConfirm;
  final String label;
  final Color accentColor;
  final LinearGradient accentGradient;

  const _SwipeToConfirm({
    required this.onConfirm,
    required this.label,
    required this.accentColor,
    required this.accentGradient,
  });

  @override
  State<_SwipeToConfirm> createState() => _SwipeToConfirmState();
}

class _SwipeToConfirmState extends State<_SwipeToConfirm> {
  double _dragProgress = 0.0;
  final double _threshold = 0.8;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        const thumbSize = 56.0;
        final slideWidth = maxWidth - thumbSize - 12;

        return Container(
          width: double.infinity,
          height: 68,
          decoration: BoxDecoration(
            color: widget.accentColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(34),
            border: Border.all(
                color: widget.accentColor.withOpacity(0.25), width: 1.5),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Progress fill
              Positioned(
                left: 0,
                child: Container(
                  width: (68 + (_dragProgress * slideWidth))
                      .clamp(68.0, maxWidth),
                  height: 68,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.accentColor.withOpacity(0.18),
                        widget.accentColor.withOpacity(0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(34),
                  ),
                ),
              ),
              // Label
              AnimatedOpacity(
                opacity: (1 - _dragProgress * 1.8).clamp(0.0, 1.0),
                duration: const Duration(milliseconds: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 60),
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: widget.accentColor.withOpacity(0.8),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.chevron_right_rounded,
                        color: widget.accentColor.withOpacity(0.5), size: 18),
                    Icon(Icons.chevron_right_rounded,
                        color: widget.accentColor.withOpacity(0.25), size: 18),
                  ],
                ),
              ),
              // Thumb
              Positioned(
                left: 6 + (_dragProgress * slideWidth),
                child: GestureDetector(
                  onHorizontalDragUpdate: (d) {
                    setState(() {
                      _dragProgress =
                          (_dragProgress + d.delta.dx / slideWidth)
                              .clamp(0.0, 1.0);
                    });
                  },
                  onHorizontalDragEnd: (_) {
                    if (_dragProgress >= _threshold) {
                      setState(() => _dragProgress = 1.0);
                      HapticFeedback.heavyImpact();
                      widget.onConfirm();
                      Future.delayed(const Duration(milliseconds: 600), () {
                        if (mounted) setState(() => _dragProgress = 0.0);
                      });
                    } else {
                      setState(() => _dragProgress = 0.0);
                    }
                  },
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      gradient: widget.accentGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: widget.accentColor.withOpacity(0.35),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
