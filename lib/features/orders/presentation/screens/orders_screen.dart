import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/classic_action_button.dart';

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
        title: const Text(
          'TRADING ORDERS',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.gold, letterSpacing: 1.0),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppColors.primaryDark,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'ACTIVE'),
                Tab(text: 'COMPLETED'),
                Tab(text: 'CANCELLED'),
              ],
              labelColor: AppColors.gold,
              unselectedLabelColor: Colors.white54,
              indicatorColor: AppColors.gold,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList('Active'),
          _buildOrdersList('Completed'),
          _buildOrdersList('Cancelled'),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String type) {
    final List<_OrderData> orders;
    if (type == 'Active') {
      orders = [
        _OrderData('GOLD MCX', '71,000', '10g', '71,240', 'PENDING', AppColors.gold, DateTime.now()),
        _OrderData('SILVER MCX', '73,500', '1kg', '74,180', 'EXECUTING', AppColors.silver, DateTime.now()),
      ];
    } else if (type == 'Completed') {
      orders = [
        _OrderData('GOLD 999', '70,500', '5g', '70,500', 'COMPLETED', AppColors.gold, DateTime.now().subtract(const Duration(days: 1))),
        _OrderData('GOLD MCX', '71,000', '2g', '71,000', 'COMPLETED', AppColors.gold, DateTime.now().subtract(const Duration(days: 2))),
      ];
    } else {
      orders = [
        _OrderData('SILVER DELHI', '75,000', '500g', '74,200', 'CANCELLED', AppColors.silver, DateTime.now().subtract(const Duration(hours: 5))),
      ];
    }

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 64, color: AppColors.textSecondary.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text('NO ${type.toUpperCase()} ORDERS', style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
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
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.primaryLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, color: order.color, size: 12),
                    const SizedBox(width: 8),
                    Text(
                      order.metal,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryDark),
                    ),
                  ],
                ),
                _buildStatusBadge(order.status, type),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetric(isActive ? 'TARGET PRICE' : (isCancelled ? 'TARGET PRICE' : 'BOUGHT AT'), '₹${order.targetPrice}'),
                _buildMetric('QUANTITY', order.qty),
                _buildMetric(isActive ? 'LTP' : 'TOTAL', isActive ? '₹${order.currentPrice}' : '₹${order.total}', isHighlight: true),
              ],
            ),
          ),
          if (isActive)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ClassicActionButton(
                label: 'CANCEL ORDER',
                icon: Icons.cancel,
                color: AppColors.error,
                onTap: () {},
              ),
            )
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMetric(String label, String value, {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isHighlight ? 18 : 16,
            color: isHighlight ? AppColors.primaryDark : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDateFooter(DateTime date) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Text(
        'PROCESSED: ${date.day} MAR 2026, ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
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

  String get total => '7,12,400';

  _OrderData(this.metal, this.targetPrice, this.qty, this.currentPrice, this.status, this.color, this.date);
}
