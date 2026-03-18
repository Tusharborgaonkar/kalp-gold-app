import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class MenuScreen extends StatelessWidget {
  final Function(int, {int? tabIndex})? onNavItemTap;
  final VoidCallback? onClose;

  const MenuScreen({
    super.key,
    this.onNavItemTap,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Allow background to show
      body: Row(
        children: [
          // 90% Main Menu Area
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.white,
            child: Column(
              children: [
                // Branded Header (Refined to match 3rd image)
                Container(
                  color: AppColors.primary,
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text(
                          'MCX',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onClose,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'MENU',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_back, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildMenuItem(Icons.bar_chart, 'LIVE RATES', onTap: () => onNavItemTap?.call(0, tabIndex: 0)),
                      _buildMenuItem(Icons.description_outlined, 'TRADES', onTap: () => onNavItemTap?.call(2)),
                      _buildMenuItem(Icons.history, 'TRADE HISTORY'),
                      _buildMenuItem(Icons.account_balance, 'BANK DETAILS'),
                      _buildMenuItem(Icons.balance, 'GOLD TRENDS', onTap: () => onNavItemTap?.call(0, tabIndex: 1)),
                      _buildMenuItem(Icons.chat_bubble_outline, 'MESSAGES', onTap: () => onNavItemTap?.call(1)),
                      _buildMenuItem(Icons.call_outlined, 'CONTACT US'),
                      _buildMenuItem(Icons.newspaper, 'NEWS'),
                      _buildMenuItem(Icons.groups_outlined, 'ABOUT US'),
                      _buildMenuItem(Icons.notifications_none, 'RATE ALERT'),
                      _buildMenuItem(Icons.timeline, 'CHART'),
                      _buildMenuItem(Icons.wallet_outlined, 'MARGIN'),
                      _buildMenuItem(Icons.login, 'LOGIN', onTap: () => onNavItemTap?.call(3)),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'VERSION 1.0.10',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          // 10% Background Area (Close trigger)
          Expanded(
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                color: Colors.black.withValues(alpha: 0.3), // Dimmed background
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textPrimary, size: 24),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onTap,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
