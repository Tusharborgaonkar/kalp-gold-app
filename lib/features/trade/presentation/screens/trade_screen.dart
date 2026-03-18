import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../kyc/presentation/screens/kyc_flow_screen.dart';
import 'order_confirmation_screen.dart';
import '../../../../core/widgets/classic_action_button.dart';

class TradeScreen extends StatefulWidget {
  final String? initialMetal;
  const TradeScreen({super.key, this.initialMetal});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  String _selectedMetal = 'GOLD MCX';
  String _selectedTimeRange = '1D';
  bool _isMarketMode = true;
  bool _isKycVerified = false; // Simulated KYC status
  double _quantity = 10.0;
  final TextEditingController _targetPriceController = TextEditingController(text: '70,000');

  final List<Map<String, String>> _metals = [
    {'name': 'GOLD MCX', 'symbol': 'Au', 'type': 'gold'},
    {'name': 'GOLD DELHI', 'symbol': 'Au', 'type': 'gold'},
    {'name': 'GOLD MUMBAI', 'symbol': 'Au', 'type': 'gold'},
    {'name': 'GOLD AHMEDABAD', 'symbol': 'Au', 'type': 'gold'},
    {'name': 'GOLD 999', 'symbol': 'Au', 'type': 'gold'},
    {'name': 'GOLD 995', 'symbol': 'Au', 'type': 'gold'},
    {'name': 'SILVER MCX', 'symbol': 'Ag', 'type': 'silver'},
    {'name': 'SILVER DELHI', 'symbol': 'Ag', 'type': 'silver'},
  ];

  bool get _isGold => _selectedMetal.startsWith('GOLD');
  Color get _metalAccent => _isGold ? AppColors.gold : AppColors.silver;

  @override
  void initState() {
    super.initState();
    if (widget.initialMetal != null) _selectedMetal = widget.initialMetal!;
  }

  @override
  void dispose() {
    _targetPriceController.dispose();
    super.dispose();
  }

  void _showMetalSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      builder: (context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'SELECT ASSET',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ..._metals.map((metal) {
                  final isSelected = _selectedMetal == metal['name'];
                  return InkWell(
                    onTap: () {
                      setState(() => _selectedMetal = metal['name']!);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            metal['name']!,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isSelected) const Icon(Icons.check, color: AppColors.gold, size: 20),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: InkWell(
          onTap: _showMetalSelector,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedMetal,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Icon(Icons.arrow_drop_down, color: AppColors.gold),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPricePanel(),
            _buildChartArea(),
            _buildTradingPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildPricePanel() {
    return Container(
      color: AppColors.primaryDark,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('LTP', style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    '₹71,240',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: _metalAccent,
                      letterSpacing: -1.0,
                    ),
                  ),
                ],
              ),
              Container(
                color: AppColors.success.withValues(alpha: 0.1),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  '+0.82%',
                  style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statText('HIGH', '₹71,890', AppColors.success),
              _statText('LOW', '₹70,640', AppColors.error),
              _statText('OPEN', '₹70,660', Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statText(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: AppColors.gold, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: valueColor, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildChartArea() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(color: AppColors.silverLight, strokeWidth: 1),
                ),
                titlesData: const FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 2.8),
                      FlSpot(0.7, 3.6),
                      FlSpot(1.5, 2.5),
                      FlSpot(2, 4.3),
                      FlSpot(2.8, 3.5),
                      FlSpot(3.3, 4.7),
                      FlSpot(4, 5.0),
                    ],
                    isCurved: false,
                    color: _metalAccent,
                    barWidth: 2,
                    isStrokeCapRound: false,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['1D', '5D', '1M', '3M', '6M', '1Y'].map((range) {
                final isSelected = _selectedTimeRange == range;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTimeRange = range),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      range,
                      style: TextStyle(
                        color: isSelected ? AppColors.gold : AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradingPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _modeTab('MARKET', true),
              _modeTab('PENDING', false),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: _isMarketMode ? _buildMarketMode() : _buildTargetPriceMode(),
          ),
        ],
      ),
    );
  }

  Widget _modeTab(String title, bool isMarket) {
    final isActive = _isMarketMode == isMarket;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isMarketMode = isMarket),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryDark : AppColors.background,
            border: Border.all(color: AppColors.primaryDark),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? AppColors.gold : AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMarketMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('QUANTITY (grams)', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        Row(
          children: [
            _qtyBtn(Icons.remove, () {
              if (_quantity > 1) setState(() => _quantity -= 1);
            }),
            Expanded(
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border.symmetric(horizontal: BorderSide(color: AppColors.primary)),
                ),
                child: Text(
                  _quantity.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
              ),
            ),
            _qtyBtn(Icons.add, () => setState(() => _quantity += 1)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [1.0, 5.0, 10.0, 50.0].map((q) => Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _quantity = q),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _quantity == q ? AppColors.primary : AppColors.background,
                  border: Border.all(color: AppColors.primary),
                ),
                child: Text(
                  '${q.toStringAsFixed(0)}g',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _quantity == q ? AppColors.gold : AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.background,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TOTAL VALUE', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              Text(
                '₹${(71240 * _quantity).toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ClassicActionButton(
            label: 'PLACE BUY ORDER',
            icon: Icons.check_circle,
            onTap: _showConfirmation,
          ),
        ),
      ],
    );
  }

  Widget _buildTargetPriceMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PENDING PRICE', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        TextField(
          controller: _targetPriceController,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixText: '₹ ',
            border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.primary)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.silverLight)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.primary, width: 2)),
          ),
        ),
        const SizedBox(height: 16),
        const Text('QUANTITY (grams)', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: _quantity.toStringAsFixed(0)),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            suffixText: 'g',
            border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.primary)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.silverLight)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.primary, width: 2)),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ClassicActionButton(
            label: 'PLACE PENDING ORDER',
            icon: Icons.gavel,
            onTap: _showConfirmation,
          ),
        ),
      ],
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: AppColors.primary),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
    );
  }

  void _initiatePurchase() {
    HapticFeedback.mediumImpact();
    final tradeDetails = {
      'asset': _selectedMetal,
      'quantity': _quantity.toStringAsFixed(0),
      'price': '71,240',
      'total': (71240 * _quantity).toStringAsFixed(0),
      'isGold': _isGold,
    };

    if (!_isKycVerified) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KYCFlowScreen(
            onVerificationComplete: () {
              setState(() => _isKycVerified = true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirmationScreen(tradeDetails: tradeDetails),
                ),
              );
            },
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(tradeDetails: tradeDetails),
        ),
      );
    }
  }

  void _showConfirmation() {
    _initiatePurchase();
  }
}