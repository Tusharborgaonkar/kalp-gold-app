import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/classic_section_header.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onLogout;
  const ProfileScreen({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'MY PROFILE',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.gold, letterSpacing: 1.0),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: AppSpacing.l),
            _buildWalletCard(),
            const SizedBox(height: AppSpacing.l),
            _buildMenuSection('ACCOUNT DETAILS', [
              _MenuItemData(Icons.person, 'PERSONAL INFORMATION', 'Name, Email, Phone'),
              _MenuItemData(Icons.account_balance, 'BANK ACCOUNTS', 'Manage linked banks'),
            ]),
            const SizedBox(height: AppSpacing.l),
            _buildMenuSection('SECURITY & KYC', [
              _MenuItemData(Icons.lock, 'CHANGE PASSWORD', 'Secure your account'),
              _MenuItemData(Icons.verified_user, 'KYC VERIFICATION', 'Verify your identity'),
            ]),
            const SizedBox(height: AppSpacing.l),
            _buildMenuSection('SUPPORT & OPTIONS', [
              _MenuItemData(Icons.help, 'HELP & SUPPORT', 'FAQs and contact us'),
              _MenuItemData(Icons.power_settings_new, 'LOGOUT', 'Sign out of your account', isDestructive: true, onTap: onLogout),
            ]),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      color: AppColors.primaryDark,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary,
              border: Border.all(color: AppColors.gold, width: 2),
            ),
            child: const Center(
              child: Text('JT', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.gold)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JAMES THOMPSON',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.0),
                ),
                SizedBox(height: 4),
                Text(
                  'james.t@example.com',
                  style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'ID: MKT-8932',
                  style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.primaryLight,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FUNDS BALANCE', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 12)),
                  Icon(Icons.account_balance_wallet, color: AppColors.primaryDark, size: 20),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('₹', style: TextStyle(color: AppColors.textSecondary, fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Text('4,52,000.00', style: TextStyle(color: AppColors.textPrimary, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -1)),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.silverLight),
            Row(
              children: [
                Expanded(child: _buildWalletAction('DEPOSIT', Icons.add_circle, AppColors.success)),
                Container(width: 1, height: 48, color: AppColors.silverLight),
                Expanded(child: _buildWalletAction('WITHDRAW', Icons.remove_circle, AppColors.error)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletAction(String label, IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_MenuItemData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClassicSectionHeader(title: title),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(horizontal: BorderSide(color: AppColors.silverLight)),
          ),
          child: Column(
            children: items.map((item) => _buildMenuItem(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(_MenuItemData item) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.silverLight)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          item.icon,
          color: item.isDestructive ? AppColors.error : AppColors.primary,
          size: 24,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: item.isDestructive ? AppColors.error : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          item.subtitle,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.silverLight, size: 14),
        onTap: item.onTap ?? () {},
      ),
    );
  }
}

class _MenuItemData {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDestructive;
  final VoidCallback? onTap;

  _MenuItemData(this.icon, this.title, this.subtitle, {this.isDestructive = false, this.onTap});
}
