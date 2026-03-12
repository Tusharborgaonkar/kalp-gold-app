import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('My Orders'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
            decoration: const BoxDecoration(color: Colors.white),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'History'),
              ],
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(true),
                _buildOrdersList(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(bool isActive) {
    final orders = isActive 
      ? [
          _OrderData('Gold', '61.50', '5g', 'Pending', AppColors.gold),
          _OrderData('Silver', '0.75', '500g', 'Executing', AppColors.silver),
        ]
      : [
          _OrderData('Gold', '60.20', '2g', 'Completed', AppColors.gold),
          _OrderData('Gold', '59.80', '10g', 'Completed', AppColors.gold),
          _OrderData('Silver', '0.72', '1kg', 'Completed', AppColors.silver),
        ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.m),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order.metal, order.price, order.qty, order.status, order.color, isActive);
      },
    );
  }

  Widget _buildOrderCard(String metal, String price, String qty, String status, Color color, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 12),
                  Text(metal, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary.withValues(alpha: 0.1) : AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isActive ? 'ACTIVE' : 'COMPLETED',
                  style: TextStyle(
                    color: isActive ? AppColors.primary : AppColors.success,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOrderDetail('Target Price', '\$$price'),
              _buildOrderDetail('Quantity', qty),
              _buildOrderDetail('Total', '\$${(double.tryParse(price) ?? 0 * 10).toStringAsFixed(2)}'),
            ],
          ),
          if (isActive) ...[
            const SizedBox(height: AppSpacing.m),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Cancel Order'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      ],
    );
  }
}

class _OrderData {
  final String metal;
  final String price;
  final String qty;
  final String status;
  final Color color;

  _OrderData(this.metal, this.price, this.qty, this.status, this.color);
}
