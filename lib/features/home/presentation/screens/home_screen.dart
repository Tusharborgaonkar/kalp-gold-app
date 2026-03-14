import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/classic_rate_card.dart';
import '../../../../core/widgets/classic_section_header.dart';
import '../../../../core/widgets/classic_action_button.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onTrade;
  const HomeScreen({super.key, this.onTrade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              'JAMES DOE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary, // Dark Navy Blue
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: AppColors.gold),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildPortfolioCard(),
            const SizedBox(height: 16),
            _buildMarketIndicators(),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 16),
            _buildRecentTransactions(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioCard() {
    return Container(
      width: double.infinity,
      color: AppColors.primaryDark,
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL INVESTMENT',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.trending_up, color: AppColors.success, size: 16),
                  const SizedBox(width: 4),
                  const Text(
                    '+₹2,450',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
          const Text(
            '₹14,45,250',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: AppSpacing.l),
          Row(
            children: [
              Expanded(child: _buildHoldingCard('GOLD', '24.5g', '₹9,40,000')),
              const SizedBox(width: AppSpacing.m),
              Expanded(child: _buildHoldingCard('SILVER', '1.2kg', '₹5,05,250')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingCard(String label, String qty, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.gold, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            qty,
            style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketIndicators() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ClassicSectionHeader(title: 'LIVE MARKET RATES', backgroundColor: AppColors.goldLight),
        Container(
          color: AppColors.primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: ClassicRateCard(title: 'GOLD COMEX', value: '2045.50', highLow: '2030.10 | 2051.80')),
              Expanded(child: ClassicRateCard(title: 'SILVER COMEX', value: '23.12', highLow: '22.90 | 23.45')),
              Expanded(child: ClassicRateCard(title: 'USD INR', value: '83.12', highLow: '83.05 | 83.20')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: ClassicActionButton(label: 'BUY GOLD', icon: Icons.add_shopping_cart, onTap: onTrade)),
          const SizedBox(width: 8),
          Expanded(child: ClassicActionButton(label: 'BUY SILVER', icon: Icons.shopping_bag_outlined, onTap: onTrade, color: AppColors.primaryDark)),
          const SizedBox(width: 8),
          const Expanded(child: ClassicActionButton(label: 'ORDERS', icon: Icons.history, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ClassicSectionHeader(title: 'RECENT TRANSACTIONS', actionLabel: 'SEE ALL'),
        _buildTransactionItem('Gold Purchase', 'Today, 14:20', '+\$520.00', true),
        _buildTransactionItem('Silver Purchase', 'Yesterday, 09:15', '+\$120.00', true),
        _buildTransactionItem('Deposit', 'Mon, 10:00', '+\$1,000.00', true),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String date, String amount, bool isCredit) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(AppSpacing.m),
      margin: const EdgeInsets.only(bottom: 2), // Thin divider effect
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: isCredit ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
              child: Icon(
                isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                color: isCredit ? AppColors.success : AppColors.error,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isCredit ? AppColors.success : AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}