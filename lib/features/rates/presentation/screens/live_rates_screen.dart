import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class LiveRatesScreen extends StatefulWidget {
  final Function(String?)? onTrade;
  const LiveRatesScreen({super.key, this.onTrade});

  @override
  State<LiveRatesScreen> createState() => _LiveRatesScreenState();
}

class _LiveRatesScreenState extends State<LiveRatesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SUVIDHI JEWELEX', // Replace with dynamic if needed
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
                fontSize: 20,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              'LIVE RATES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.gold.withValues(alpha: 0.8),
                fontSize: 12,
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
            icon: const Icon(Icons.refresh_rounded, color: AppColors.gold),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildMarketIndicators(),
            _buildPriceBoard(),
            const SizedBox(height: 80), // Padding for Floating Action Buttons
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'callBtn',
              onPressed: () {},
              backgroundColor: AppColors.error, // Red for Call
              child: const Icon(Icons.phone, color: Colors.white, size: 28),
            ),
            FloatingActionButton(
              heroTag: 'waBtn',
              onPressed: () {},
              backgroundColor: AppColors.success, // Green for WhatsApp
              child: const Icon(Icons.chat, color: Colors.white, size: 28), // Placeholder for WA icon
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketIndicators() {
    return Container(
      color: AppColors.primaryLight,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIndicatorCard('GOLD COMEX', '2045.50', '2030.10 | 2051.80'),
          _buildIndicatorCard('SILVER COMEX', '23.12', '22.90 | 23.45'),
          _buildIndicatorCard('USD INR', '83.12', '83.05 | 83.20'),
        ],
      ),
    );
  }

  Widget _buildIndicatorCard(String title, String value, String highLow) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              highLow,
              style: const TextStyle(color: Colors.white54, fontSize: 8),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBoard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildProductCategory('GOLD PRODUCT', [
            {'category': 'GOLD', 'name': 'GOLD 999 LOCAL', 'price': '163533', 'active': true},
            {'category': 'GOLD', 'name': 'GOLD 999 INDIAN T+1', 'price': '163636', 'active': true},
            {'category': 'GOLD', 'name': 'GOLD 999 IMP T+1', 'price': '164182', 'active': true},
          ]),
          const SizedBox(height: 8),
          _buildProductCategory('SILVER PRODUCT', [
            {'category': 'SILVER', 'name': 'Silver T+1', 'price': '268218', 'active': true},
            {'category': 'SILVER', 'name': '30 kg T+1', 'price': '268270', 'active': true},
          ]),
        ],
      ),
    );
  }

  Widget _buildProductCategory(String title, List<Map<String, dynamic>> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Category Header
        Container(
          color: AppColors.goldLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const Text(
                'BUY',
                style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),
        // Product Rows
        ...products.map((p) => _buildProductRow(p)).toList(),
      ],
    );
  }

  Widget _buildProductRow(Map<String, dynamic> product) {
    return InkWell(
      onTap: () {
        // Map to existing Trade keys if necessary
        String? tradeKey;
        if (product['name'].contains('GOLD 999')) tradeKey = 'GOLD 999';
        if (product['name'].contains('Silver T+1')) tradeKey = 'SILVER MCX';
        widget.onTrade?.call(tradeKey);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: AppColors.background, width: 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                product['name'],
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                product['price'],
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              product['active'] ? Icons.check_circle : Icons.remove_circle,
              color: product['active'] ? AppColors.success : AppColors.textSecondary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

