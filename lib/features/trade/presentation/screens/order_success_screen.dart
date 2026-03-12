import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class OrderSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> tradeDetails;

  const OrderSuccessScreen({super.key, required this.tradeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    size: 80, color: AppColors.success),
              ),
              const SizedBox(height: 32),
              const Text(
                'Order Successful 🎉',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'You successfully bought ${tradeDetails['quantity']}g ${tradeDetails['asset']}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    _row('Order ID', '#MCX${100000 + (DateTime.now().millisecond * 13) % 999999}'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1),
                    ),
                    _row('Total Paid', '₹${tradeDetails['total']}'),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Back to Home',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: const Text('View Orders',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
        Text(value,
            style: const TextStyle(
                color: AppColors.textPrimary, fontWeight: FontWeight.w800)),
      ],
    );
  }
}
