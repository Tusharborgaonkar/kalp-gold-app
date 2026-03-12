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
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('Trading Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList('Active'),
                _buildOrdersList('Completed'),
                _buildOrdersList('Cancelled'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String type) {
    final List<_OrderData> orders;
    if (type == 'Active') {
      orders = [
        _OrderData('GOLD MCX', '71,000', '10g', '71,240', 'Pending', AppColors.gold, DateTime.now()),
        _OrderData('SILVER MCX', '73,500', '1kg', '74,180', 'Executing', AppColors.silver, DateTime.now()),
      ];
    } else if (type == 'Completed') {
      orders = [
        _OrderData('GOLD 999', '70,500', '5g', '70,500', 'Completed', AppColors.gold, DateTime.now().subtract(const Duration(days: 1))),
        _OrderData('GOLD MCX', '71,000', '2g', '71,000', 'Completed', AppColors.gold, DateTime.now().subtract(const Duration(days: 2))),
      ];
    } else {
      orders = [
        _OrderData('SILVER DELHI', '75,000', '500g', '74,200', 'Cancelled', AppColors.silver, DateTime.now().subtract(const Duration(hours: 5))),
      ];
    }

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 64, color: AppColors.textSecondary.withValues(alpha: 0.2)),
            const SizedBox(height: 16),
            Text('No $type orders found', style: const TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.m),
      physics: const BouncingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) => _buildOrderCard(orders[index], type),
    );
  }

  Widget _buildOrderCard(_OrderData order, String type) {
    final bool isActive = type == 'Active';
    final bool isCancelled = type == 'Cancelled';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: order.color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      order.metal,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: -0.5),
                    ),
                  ],
                ),
                _buildStatusBadge(order.status, type),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetric(isActive ? 'Target Price' : (isCancelled ? 'Target Price' : 'Bought at'), '₹${order.targetPrice}'),
                _buildMetric('Quantity', order.qty),
                _buildMetric(isActive ? 'Current Price' : 'Total', isActive ? '₹${order.currentPrice}' : '₹${order.total}'),
              ],
            ),
          ),
          if (isActive)
            _buildCancelButton()
          else
            _buildDateFooter(order.date),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status, String type) {
    Color color = AppColors.primary;
    if (type == 'Completed') color = AppColors.success;
    if (type == 'Cancelled') color = AppColors.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
      ],
    );
  }

  Widget _buildCancelButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(color: Color(0xFFFEE2E2)),
          backgroundColor: const Color(0xFFFEF2F2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: const Text('CANCEL ORDER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  Widget _buildDateFooter(DateTime date) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Text(
        'Processed on ${date.day} Mar 2026, ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _OrderData {
  final String metal;
  final String targetPrice;
  final String qty;
  final String currentPrice;
  final String status;
  final Color color;
  final DateTime date;

  String get total => '7,12,400'; // Mock logic

  _OrderData(this.metal, this.targetPrice, this.qty, this.currentPrice, this.status, this.color, this.date);
}
