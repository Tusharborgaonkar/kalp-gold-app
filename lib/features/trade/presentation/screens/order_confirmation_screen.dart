import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/constants.dart';
import 'order_success_screen.dart';
import '../../../../core/widgets/classic_section_header.dart';
import '../../../../core/widgets/classic_action_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> tradeDetails;
  
  const OrderConfirmationScreen({super.key, required this.tradeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'CONFIRM PURCHASE',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.gold, letterSpacing: 1.0),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClassicSectionHeader(title: 'ORDER DETAILS'),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  _row('Asset', tradeDetails['asset']),
                  const Divider(height: 1, color: AppColors.silverLight),
                  _row('Quantity', '${tradeDetails['quantity']}g'),
                  const Divider(height: 1, color: AppColors.silverLight),
                  _row('Price', '₹${tradeDetails['price']}'),
                  const Divider(height: 1, color: AppColors.silverLight),
                  _row('Total', '₹${tradeDetails['total']}', isBold: true, color: AppColors.primary),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ClassicSectionHeader(title: 'PAYMENT METHOD'),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: const Icon(Icons.account_balance_wallet, color: AppColors.primaryDark),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Wallet Balance', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        Text('Instant Transfer', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('₹4,52,000', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ClassicActionButton(
                  label: 'CONFIRM ORDER',
                  icon: Icons.check_circle,
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OrderSuccessScreen(tradeDetails: tradeDetails)),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false, Color color = AppColors.textPrimary}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(value, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isBold ? 18 : 16,
            color: color,
          )),
        ],
      ),
    );
  }
}
