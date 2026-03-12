import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../widgets/metal_sparkline.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onTrade;
  const HomeScreen({super.key, this.onTrade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background shapes for "Mesh" feel
          Positioned(
            top: -100,
            right: -100,
            child: _buildMeshCircle(AppColors.primary.withValues(alpha: 0.1), 300),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildMeshCircle(AppColors.primaryLight.withValues(alpha: 0.1), 250),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: AppSpacing.l),
                  _buildPortfolioCard(),
                  const SizedBox(height: AppSpacing.l),
                  _buildMarketRates(),
                  const SizedBox(height: AppSpacing.l),
                  _buildQuickActions(),
                  const SizedBox(height: AppSpacing.l),
                  _buildRecentTransactions(),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeshCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, James',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        // Avatar with Gradient Border effect
        Container(
          decoration: const BoxDecoration(
            gradient: AppColors.actionGradient,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(2),
            child: const CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 20,
              child: Icon(Icons.notifications_none, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Investment',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.trending_up, color: AppColors.success, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '+₹2,450 (1.8%)',
                        style: const TextStyle(
                          color: AppColors.success,
                          fontSize: 12,
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
                  Expanded(child: _buildHoldingCard('Gold', '24.5g', '₹9,40,000', '+2.4%', AppColors.gold)),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(child: _buildHoldingCard('Silver', '1.2kg', '₹5,05,250', '-0.5%', AppColors.silver)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingCard(String label, String qty, String value, String change, Color color) {
    bool isPositive = change.startsWith('+');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
              ),
              Text(
                change,
                style: TextStyle(
                  color: isPositive ? AppColors.success : AppColors.error,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
          ),
          Text(
            qty,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketRates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live Market Rates',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.m),
        Row(
          children: [
            Expanded(child: _buildRateCard('Gold', '62.40', '+1.2%', AppColors.gold)),
            const SizedBox(width: AppSpacing.m),
            Expanded(child: _buildRateCard('Silver', '0.78', '-0.5%', AppColors.silver)),
          ],
        ),
      ],
    );
  }

  Widget _buildRateCard(String metal, String price, String change, Color color) {
    bool isPositive = change.startsWith('+');
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  metal == 'Gold' ? Icons.star : Icons.circle,
                  color: color,
                  size: 18,
                ),
              ),
              MetalSparkline(
                color: isPositive ? AppColors.success : AppColors.error,
                data: isPositive ? const [1, 2, 1.5, 3, 2.8, 4] : const [4, 3, 3.5, 2, 2.2, 1],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            metal,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$$price',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isPositive ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              change,
              style: TextStyle(
                color: isPositive ? AppColors.success : AppColors.error,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton('Buy Gold', Icons.add_shopping_cart, AppColors.gold),
        _buildActionButton('Buy Silver', Icons.shopping_bag_outlined, AppColors.silver),
        _buildActionButton('Orders', Icons.history, AppColors.primary),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return InkWell(
      onTap: onTrade,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              child: const Text('See all', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s),
        _buildTransactionItem('Gold Purchase', 'Today, 14:20', '+\$520.00', true),
        _buildTransactionItem('Silver Purchase', 'Yesterday, 09:15', '+\$120.00', true),
        _buildTransactionItem('Deposit', 'Mon, 10:00', '+\$1,000.00', true),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String date, String amount, bool isCredit) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCredit ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                color: isCredit ? AppColors.success : AppColors.error,
                size: 22,
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
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: isCredit ? AppColors.success : AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}