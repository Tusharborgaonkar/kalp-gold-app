import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/diamond_pattern_painter.dart';

class TradeHistoryScreen extends StatelessWidget {
  const TradeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Trades History',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Geometric Background Pattern (Diamond/Grid)
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: DiamondPatternPainter(),
              ),
            ),
          ),
          
          Column(
            children: [
              const SizedBox(height: 20),
              // Table Header
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Symbol',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'B/S',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Qty',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Price',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Table Body (Mock Data for now)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 15, // Mock count
                  itemBuilder: (context, index) {
                    final isEven = index % 2 == 0;
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        color: isEven ? Colors.white.withValues(alpha: 0.5) : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              index % 3 == 0 ? 'GOLD MCX' : (index % 2 == 0 ? 'SILVER MCX' : 'GOLD 999'),
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              index % 2 == 0 ? 'BUY' : 'SELL',
                              style: TextStyle(
                                color: index % 2 == 0 ? AppColors.success : AppColors.error,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              index % 3 == 0 ? '10g' : '1kg',
                              style: const TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              index % 2 == 0 ? '₹71,240' : '₹74,180',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

