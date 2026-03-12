import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Mesh Background
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.m),
                  _buildProfileHeader(),
                  const SizedBox(height: AppSpacing.xl),
                  _buildWalletCard(),
                  const SizedBox(height: AppSpacing.xl),
                  _buildMenuSection('Account', [
                    _MenuItemData(Icons.person_outline, 'Personal Information', 'Name, Email, Phone'),
                    _MenuItemData(Icons.account_balance_wallet_outlined, 'Bank Accounts', 'Manage linked banks'),
                  ]),
                  const SizedBox(height: AppSpacing.l),
                  _buildMenuSection('Security', [
                    _MenuItemData(Icons.lock_outline, 'Change Password', 'Secure your account'),
                    _MenuItemData(Icons.verified_user_outlined, 'KYC Verification', 'Verify your identity'),
                  ]),
                  const SizedBox(height: AppSpacing.l),
                  _buildMenuSection('Other', [
                    _MenuItemData(Icons.help_outline, 'Help & Support', 'FAQs and contact us'),
                    _MenuItemData(Icons.logout, 'Logout', 'Sign out of your account', isDestructive: true),
                  ]),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
          ),
          child: const CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primary,
            child: Text('JT', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
        const SizedBox(height: AppSpacing.m),
        const Text('James Thompson', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
        const SizedBox(height: 4),
        const Text('james.t@example.com', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      ],
    );
  }

  Widget _buildWalletCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Wallet Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text('\$4,520.00', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -1)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 28),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          Row(
            children: [
              Expanded(child: _buildWalletAction('Deposit', Icons.add_rounded)),
              const SizedBox(width: AppSpacing.m),
              Expanded(child: _buildWalletAction('Withdraw', Icons.remove_rounded)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletAction(String label, IconData icon) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_MenuItemData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.s, bottom: AppSpacing.m),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
        ),
        ...items.map((item) => _buildMenuItem(item)),
      ],
    );
  }

  Widget _buildMenuItem(_MenuItemData item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (item.isDestructive ? AppColors.error : AppColors.primary).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(item.icon, color: item.isDestructive ? AppColors.error : AppColors.primary, size: 22),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: item.isDestructive ? AppColors.error : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(item.subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary, size: 20),
        onTap: () {},
      ),
    );
  }
}

class _MenuItemData {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDestructive;

  _MenuItemData(this.icon, this.title, this.subtitle, {this.isDestructive = false});
}
