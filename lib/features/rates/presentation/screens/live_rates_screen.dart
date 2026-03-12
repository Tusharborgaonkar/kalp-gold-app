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
        title: const Text(
          'Live Market Rates',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 22,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded, color: AppColors.primary),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTicker(),
          _buildTabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRatesView('GOLD', AppColors.gold, AppColors.goldGradient),
                _buildRatesView('SILVER', AppColors.silver, AppColors.silverGradient),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => widget.onTrade?.call(null), // Navigate to Trade
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
        label: const Text('QUICK BUY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTicker() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        border: const Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 20),
            _TickerItem(label: 'MCX GOLD', value: '62,450', change: '+120', isUp: true),
            SizedBox(width: 30),
            _TickerItem(label: 'MCX SILVER', value: '74,200', change: '-450', isUp: false),
            SizedBox(width: 30),
            _TickerItem(label: 'USD/INR', value: '83.12', change: '+0.05', isUp: true),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'GOLD LIVE'),
          Tab(text: 'SILVER LIVE'),
        ],
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }

  Widget _buildRatesView(String metal, Color metalColor, LinearGradient gradient) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.m),
      children: [
        _buildSpotlight(metal, metalColor, gradient),
        const SizedBox(height: 24),
        _buildRatesTable(metal, metalColor),
        const SizedBox(height: 24),
        _buildComexSection(),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSpotlight(String metal, Color metalColor, LinearGradient gradient) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: metalColor.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'MCX $metal SPOT',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          ShaderMask(
            shaderCallback: (bounds) => gradient.createShader(bounds),
            child: Text(
              metal == 'GOLD' ? '62,410' : '74,180',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildSpotlightMiniItem('HIGH', metal == 'GOLD' ? '62,580' : '74,500', AppColors.success),
              const SizedBox(width: 12),
              _buildSpotlightMiniItem('LOW', metal == 'GOLD' ? '62,320' : '73,900', AppColors.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpotlightMiniItem(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(color: color.withValues(alpha: 0.6), fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatesTable(String metal, Color metalColor) {
        final products = metal == 'GOLD'
        ? [
            {'name': 'GOLD 999 (10 GM)', 'buy': '62,410'},
            {'name': 'GOLD 995 (10 GM)', 'buy': '62,310'},
            {'name': 'GOLD RTGS', 'buy': '62,400'},
          ]
        : [
            {'name': 'SILVER 999 (1 KG)', 'buy': '74,180'},
            {'name': 'SILVER RTGS', 'buy': '74,170'},
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PHYSICAL MARKET',
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.8),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: metalColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'LIVE',
                style: TextStyle(color: metalColor, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1.5),
              2: IntrinsicColumnWidth(),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                children: [
                  _buildTableHeader('PRODUCT'),
                  _buildTableHeader('BUY PRICE'),
                  const SizedBox(), // Spacer for BUY button
                ],
              ),
              ...products.map((p) => TableRow(
                    children: [
                      _buildTableCell(p['name']!, isBold: true),
                      _buildTableCell(p['buy']!, color: AppColors.success),
                      _buildQuickBuyButton(p['name']!),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.textPrimary,
          fontSize: 13,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildQuickBuyButton(String name) {
    // Map product names to consistent TradeScreen keys
    String? tradeKey;
    if (name.contains('GOLD 999')) tradeKey = 'GOLD 999';
    if (name.contains('GOLD 995')) tradeKey = 'GOLD 995';
    if (name.contains('GOLD RTGS')) tradeKey = 'GOLD MCX';
    if (name.contains('SILVER 999')) tradeKey = 'SILVER MCX';
    if (name.contains('SILVER RTGS')) tradeKey = 'SILVER MCX';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: () => widget.onTrade?.call(tradeKey),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.success.withValues(alpha: 0.1),
          foregroundColor: AppColors.success,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: const Text('BUY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
      ),
    );
  }

  Widget _buildComexSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.public_rounded, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              const Flexible(
                child: Text(
                  'COMEX INTERNATIONAL',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              _buildPulsingDot(),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _ComexItem(label: 'GOLD USD', value: '2,045.50', change: '+12.40')),
              SizedBox(width: 16),
              Expanded(child: _ComexItem(label: 'SILVER USD', value: '23.12', change: '-0.15')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPulsingDot() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'LIVE',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _TickerItem extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  final bool isUp;

  const _TickerItem({
    required this.label,
    required this.value,
    required this.change,
    required this.isUp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Text(
          change,
          style: TextStyle(
            color: isUp ? AppColors.success : AppColors.error,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ComexItem extends StatelessWidget {
  final String label;
  final String value;
  final String change;

  const _ComexItem({required this.label, required this.value, required this.change});

  @override
  Widget build(BuildContext context) {
    bool isUp = change.startsWith('+');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -0.5), maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 2),
        Text(
          change,
          style: TextStyle(color: isUp ? AppColors.success : AppColors.error, fontSize: 14, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
