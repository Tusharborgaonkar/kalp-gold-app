import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../kyc/presentation/screens/kyc_flow_screen.dart';
import 'order_confirmation_screen.dart';

class TradeScreen extends StatefulWidget {
  final String? initialMetal;
  const TradeScreen({super.key, this.initialMetal});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> with TickerProviderStateMixin {
  String _selectedMetal = 'GOLD MCX';
  String _selectedTimeRange = '1D';
  bool _isMarketMode = true;
  bool _isKycVerified = false; // Simulated KYC status
  double _quantity = 10.0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _targetPriceController =
      TextEditingController(text: '70,000');

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
  LinearGradient get _metalGradient =>
      _isGold ? AppColors.goldGradient : AppColors.silverGradient;

  @override
  void initState() {
    super.initState();
    if (widget.initialMetal != null) _selectedMetal = widget.initialMetal!;
    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _targetPriceController.dispose();
    super.dispose();
  }

  void _showMetalSelector() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColors.silverLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'SELECT ASSET',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.5,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(_metals.length, (index) {
              final metal = _metals[index];
              final isSelected = _selectedMetal == metal['name'];
              final isGoldType = metal['type'] == 'gold';
              final accent = isGoldType ? AppColors.gold : AppColors.silver;
              final gradient = isGoldType
                  ? AppColors.goldGradient
                  : AppColors.silverGradient;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedMetal = metal['name']!);
                  HapticFeedback.selectionClick();
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? accent.withOpacity(0.08)
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? accent.withOpacity(0.4)
                          : AppColors.silverLight,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          gradient: gradient,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: accent.withOpacity(0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            metal['symbol']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        metal['name']!,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            gradient: gradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check,
                              color: Colors.white, size: 13),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildPriceHero(),
                    _buildStatsBar(),
                    _buildTradingPanel(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      forceElevated: true,
      shadowColor: Colors.black.withOpacity(0.06),
      leading: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.silverLight),
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary, size: 15),
      ),
      title: GestureDetector(
        onTap: _showMetalSelector,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.silverLight),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  gradient: _metalGradient,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _isGold ? 'Au' : 'Ag',
                    style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _selectedMetal,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary, size: 18),
            ],
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.silverLight),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_none_rounded,
                color: AppColors.textPrimary, size: 18),
            onPressed: () {},
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceHero() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LIVE PRICE',
                    style: TextStyle(
                      color: AppColors.textSecondary.withOpacity(0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        _metalGradient.createShader(bounds),
                    child: const Text(
                      '₹71,240',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -1.5,
                        height: 1.05,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.success.withOpacity(0.2)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up_rounded,
                        color: AppColors.success, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '+0.82%',
                      style: TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Main Chart
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: AppColors.silverLight.withOpacity(0.5),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (val, _) {
                        const labels = ['9AM', '11AM', '1PM', '3PM', '5PM'];
                        final i = val.toInt();
                        if (i >= 0 && i < labels.length) {
                          return Text(labels[i],
                              style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
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
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: _metalAccent,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, _) => spot.x == 4.0,
                      getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                        radius: 6,
                        color: _metalAccent,
                        strokeWidth: 3,
                        strokeColor: Colors.white,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _metalAccent.withOpacity(0.25),
                          _metalAccent.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Time Range Selectors
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['1D', '5D', '1M', '3M', '6M', '1Y'].map((range) {
                final isSelected = _selectedTimeRange == range;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedTimeRange = range);
                    HapticFeedback.selectionClick();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _metalAccent.withOpacity(0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      range,
                      style: TextStyle(
                        color:
                            isSelected ? _metalAccent : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w600,
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

  Widget _buildStatsBar() {
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 4, 20, 16),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.silverLight),
        ),
        child: Row(
          children: [
            _stat('HIGH', '₹71,890', AppColors.success),
            _statDivider(),
            _stat('LOW', '₹70,640', AppColors.error),
            _statDivider(),
            _stat('OPEN', '₹70,660', AppColors.textSecondary),
            _statDivider(),
            _stat('VOL', '2.4K', AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value, Color valueColor) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  color: valueColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _statDivider() =>
      Container(width: 1, height: 26, color: AppColors.silverLight);

  Widget _buildTradingPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        children: [
          // Mode toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.silverLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _modeTab('Market', true),
                _modeTab('Target Price', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Panel
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child:
                _isMarketMode ? _buildMarketMode() : _buildTargetPriceMode(),
          ),
        ],
      ),
    );
  }

  Widget _modeTab(String title, bool isMarket) {
    final isActive = _isMarketMode == isMarket;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _isMarketMode = isMarket);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Text(
            title,
            style: TextStyle(
              color:
                  isActive ? AppColors.primary : AppColors.textSecondary,
              fontWeight:
                  isActive ? FontWeight.w800 : FontWeight.w600,
              fontSize: 13,
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
        // Price badge row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _metalAccent.withOpacity(0.08),
                _metalAccent.withOpacity(0.03),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _metalAccent.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: _metalGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _metalAccent.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _isGold ? 'Au' : 'Ag',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CURRENT PRICE',
                      style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5)),
                  const SizedBox(height: 2),
                  ShaderMask(
                    shaderCallback: (b) => _metalGradient.createShader(b),
                    child: const Text('₹71,240',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5)),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('▲ 0.82%',
                    style: TextStyle(
                        color: AppColors.success,
                        fontSize: 11,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        const Text('QUANTITY',
            style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5)),

        const SizedBox(height: 12),

        // Stepper
        Row(
          children: [
            _qtyBtn(Icons.remove_rounded, () {
              if (_quantity > 1) setState(() => _quantity -= 1);
              HapticFeedback.lightImpact();
            }),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${_quantity.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      letterSpacing: -1,
                      height: 1,
                    ),
                  ),
                  const Text('grams',
                      style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            _qtyBtn(Icons.add_rounded, () {
              setState(() => _quantity += 1);
              HapticFeedback.lightImpact();
            }),
          ],
        ),

        const SizedBox(height: 14),

        // Quick select chips
        Row(
          children: [1.0, 5.0, 10.0, 50.0]
              .map((q) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _quantity = q);
                        HapticFeedback.selectionClick();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _quantity == q
                              ? _metalAccent.withOpacity(0.12)
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _quantity == q
                                ? _metalAccent.withOpacity(0.5)
                                : AppColors.silverLight,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          '${q.toStringAsFixed(0)}g',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _quantity == q
                                ? _metalAccent
                                : AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),

        const SizedBox(height: 20),

        // Total
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.silverLight),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('ESTIMATED TOTAL',
                  style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5)),
              ShaderMask(
                shaderCallback: (b) => _metalGradient.createShader(b),
                child: Text(
                  '₹${(71240 * _quantity).toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _SwipeToConfirm(
          onConfirm: _showConfirmation,
          label: 'Swipe to BUY',
          accentColor: _metalAccent,
          accentGradient: _metalGradient,
        ),
      ],
    );
  }

  Widget _buildTargetPriceMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TARGET PRICE',
            style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5)),
        const SizedBox(height: 8),
        TextField(
          controller: _targetPriceController,
          style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 20),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: '₹ ',
            prefixStyle: TextStyle(
                color: _metalAccent,
                fontWeight: FontWeight.w900,
                fontSize: 20),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.silverLight)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.silverLight)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    BorderSide(color: _metalAccent, width: 1.5)),
          ),
        ),
        const SizedBox(height: 16),
        const Text('QUANTITY',
            style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5)),
        const SizedBox(height: 8),
        TextField(
          controller:
              TextEditingController(text: _quantity.toStringAsFixed(0)),
          style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 20),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffixText: 'g',
            suffixStyle: TextStyle(
                color: _metalAccent, fontWeight: FontWeight.w800),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.silverLight)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.silverLight)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    BorderSide(color: _metalAccent, width: 1.5)),
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: _showConfirmation,
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: _metalGradient,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: _metalAccent.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'PLACE ORDER',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ),
      ],
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

  Widget _confirmRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
          isTotal
              ? ShaderMask(
                  shaderCallback: (b) => _metalGradient.createShader(b),
                  child: Text(value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16)))
              : Text(value,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 13)),
        ],
      ),
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
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.silverLight),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 20),
      ),
    );
  }
}

// ─── Swipe to Confirm ────────────────────────────────────────────────────────

class _SwipeToConfirm extends StatefulWidget {
  final VoidCallback onConfirm;
  final String label;
  final Color accentColor;
  final LinearGradient accentGradient;

  const _SwipeToConfirm({
    required this.onConfirm,
    required this.label,
    required this.accentColor,
    required this.accentGradient,
  });

  @override
  State<_SwipeToConfirm> createState() => _SwipeToConfirmState();
}

class _SwipeToConfirmState extends State<_SwipeToConfirm> {
  double _dragProgress = 0.0;
  final double _threshold = 0.8;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        const thumbSize = 56.0;
        final slideWidth = maxWidth - thumbSize - 12;

        return Container(
          width: double.infinity,
          height: 68,
          decoration: BoxDecoration(
            color: widget.accentColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(34),
            border: Border.all(
                color: widget.accentColor.withOpacity(0.25), width: 1.5),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Progress fill
              Positioned(
                left: 0,
                child: Container(
                  width: (68 + (_dragProgress * slideWidth))
                      .clamp(68.0, maxWidth),
                  height: 68,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.accentColor.withOpacity(0.18),
                        widget.accentColor.withOpacity(0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(34),
                  ),
                ),
              ),
              // Label
              AnimatedOpacity(
                opacity: (1 - _dragProgress * 1.8).clamp(0.0, 1.0),
                duration: const Duration(milliseconds: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 60),
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: widget.accentColor.withOpacity(0.8),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.chevron_right_rounded,
                        color: widget.accentColor.withOpacity(0.5), size: 18),
                    Icon(Icons.chevron_right_rounded,
                        color: widget.accentColor.withOpacity(0.25), size: 18),
                  ],
                ),
              ),
              // Thumb
              Positioned(
                left: 6 + (_dragProgress * slideWidth),
                child: GestureDetector(
                  onHorizontalDragUpdate: (d) {
                    setState(() {
                      _dragProgress =
                          (_dragProgress + d.delta.dx / slideWidth)
                              .clamp(0.0, 1.0);
                    });
                  },
                  onHorizontalDragEnd: (_) {
                    if (_dragProgress >= _threshold) {
                      setState(() => _dragProgress = 1.0);
                      HapticFeedback.heavyImpact();
                      widget.onConfirm();
                      Future.delayed(const Duration(milliseconds: 600), () {
                        if (mounted) setState(() => _dragProgress = 0.0);
                      });
                    } else {
                      setState(() => _dragProgress = 0.0);
                    }
                  },
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      gradient: widget.accentGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: widget.accentColor.withOpacity(0.35),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}