import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/classic_rate_card.dart';
import '../../../../core/widgets/classic_section_header.dart';
import '../../../../core/widgets/live_price_indicator.dart';

class LiveRatesScreen extends StatefulWidget {
  final Function(String?)? onTrade;
  final VoidCallback? onBack;
  const LiveRatesScreen({super.key, this.onTrade, this.onBack});

  @override
  State<LiveRatesScreen> createState() => _LiveRatesScreenState();
}

class _LiveRatesScreenState extends State<LiveRatesScreen> {
  Timer? _simulationTimer;
  
  // Market Data State
  final Map<String, Map<String, String>> _marketData = {
    'GOLD COMEX': {'value': '5018.05', 'highLow': '5044.30 | 4994.76'},
    'SILVER COMEX': {'value': '80.79', 'highLow': '82.54 | 79.87'},
    'USD INR': {'value': '92.428', 'highLow': '92.473 | 92.280'},
    'GOLD': {'value': '156604', 'value2': '156642', 'highLow': '157580 | 156266'},
    'SILVER': {'value': '257400', 'value2': '257648', 'highLow': '262899 | 257035'},
  };

  // Product Data State
  final List<Map<String, dynamic>> _goldProducts = [
    {'name': 'GOLD 999 LOCAL', 'price': '163533', 'active': true},
    {'name': 'GOLD 999 INDIAN T+1', 'price': '163636', 'active': true},
    {'name': 'GOLD 999 IMP T+1', 'price': '164182', 'active': true},
  ];

  final List<Map<String, dynamic>> _silverProducts = [
    {'name': 'Silver T+1', 'price': '268218', 'active': true},
    {'name': '30 kg T+1', 'price': '268270', 'active': true},
  ];

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  void _startSimulation() {
    final random = Random();
    _simulationTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      
      setState(() {
        // Randomly update one market value
        final marketKeys = _marketData.keys.toList();
        final randomKey = marketKeys[random.nextInt(marketKeys.length)];
        final currentVal = double.tryParse(_marketData[randomKey]!['value']!) ?? 0;
        
        // 50/50 chance for up or down using true random
        final isUp = random.nextBool();
        final magnitude = random.nextInt(3) + 1; // 1 to 3
        final change = isUp ? magnitude.toDouble() : -magnitude.toDouble();
        
        if (change != 0) {
          _marketData[randomKey]!['value'] = (currentVal + change).toStringAsFixed(randomKey.contains('INR') ? 3 : 2);
        }

        // Randomly update product prices
        for (var p in _goldProducts) {
          final cur = double.tryParse(p['price']) ?? 0;
          final pIsUp = random.nextBool();
          final pDiff = random.nextInt(5) + 1;
          p['price'] = (cur + (pIsUp ? pDiff : -pDiff)).toStringAsFixed(0);
        }
        for (var p in _silverProducts) {
          final cur = double.tryParse(p['price']) ?? 0;
          final sIsUp = random.nextBool();
          final sDiff = random.nextInt(5) + 1;
          p['price'] = (cur + (sIsUp ? sDiff : -sDiff)).toStringAsFixed(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _simulationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gold),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            } else {
              Navigator.of(context).maybePop();
            }
          },
        ),
        title: const Text(
          'LIVE RATES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
            fontSize: 18,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded, color: AppColors.gold),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.primaryLight,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Center(
              child: Text(
                'LIVE RATES',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildMarketIndicators(),
                  _buildTicker(),
                  _buildPriceBoard(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
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
              backgroundColor: AppColors.error,
              child: const Icon(Icons.phone, color: Colors.white, size: 28),
            ),
            FloatingActionButton(
              heroTag: 'waBtn',
              onPressed: () {},
              backgroundColor: AppColors.success,
              child: const Icon(Icons.chat, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketIndicators() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: ClassicRateCard(title: 'GOLD COMEX', value: _marketData['GOLD COMEX']!['value']!, highLow: _marketData['GOLD COMEX']!['highLow']!)),
              Expanded(child: ClassicRateCard(title: 'SILVER COMEX', value: _marketData['SILVER COMEX']!['value']!, highLow: _marketData['SILVER COMEX']!['highLow']!)),
              Expanded(child: ClassicRateCard(title: 'USD INR', value: _marketData['USD INR']!['value']!, highLow: _marketData['USD INR']!['highLow']!)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClassicRateCard(
                  title: 'GOLD',
                  value: _marketData['GOLD']!['value']!,
                  value2: _marketData['GOLD']!['value2'],
                  highLow: _marketData['GOLD']!['highLow']!,
                ),
              ),
              Expanded(
                child: ClassicRateCard(
                  title: 'SILVER',
                  value: _marketData['SILVER']!['value']!,
                  value2: _marketData['SILVER']!['value2'],
                  highLow: _marketData['SILVER']!['highLow']!,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTicker() {
    return Container(
      width: double.infinity,
      color: AppColors.goldLight,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const MarqueeWidget(
        text: 'Delivery Avalible  at C.G Road Manak chock Office.',
        style: TextStyle(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPriceBoard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildProductCategory('GOLD PRODUCT', _goldProducts),
          const SizedBox(height: 8),
          _buildProductCategory('SILVER PRODUCT', _silverProducts),
        ],
      ),
    );
  }

  Widget _buildProductCategory(String title, List<Map<String, dynamic>> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.goldLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const Text(
                'SELL',
                style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
        ),
        ...products.map((p) => _buildProductRow(p)).toList(),
      ],
    );
  }

  Widget _buildProductRow(Map<String, dynamic> product) {
    return InkWell(
      onTap: () {
        String? tradeKey;
        if (product['name'].contains('GOLD 999')) tradeKey = 'GOLD 999';
        if (product['name'].contains('Silver T+1')) tradeKey = 'SILVER MCX';
        widget.onTrade?.call(tradeKey);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
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
              flex: 2,
              child: LivePriceIndicator(
                price: product['price'],
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.right,
                showArrow: true,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: product['active'] ? AppColors.success : Colors.grey,
              ),
              padding: const EdgeInsets.all(2),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarqueeWidget extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const MarqueeWidget({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(seconds: 15),
  });

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() async {
    while (_scrollController.hasClients) {
      await Future.delayed(const Duration(seconds: 1));
      if (!_scrollController.hasClients) break;
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: widget.duration,
        curve: Curves.linear,
      );
      if (!_scrollController.hasClients) break;
      _scrollController.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          '${widget.text}      ${widget.text}      ${widget.text}',
          style: widget.style,
        ),
      ),
    );
  }
}

