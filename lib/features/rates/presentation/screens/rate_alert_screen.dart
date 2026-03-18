import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/diamond_pattern_painter.dart';

class RateAlertScreen extends StatefulWidget {
  const RateAlertScreen({super.key});

  @override
  State<RateAlertScreen> createState() => _RateAlertScreenState();
}

class _RateAlertScreenState extends State<RateAlertScreen> {
  String selectedCommodity = 'GOLD COMEX';
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Rate Alert',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Geometric Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: DiamondPatternPainter(),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Commodity Selector
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37), // Gold/Bronze color
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCommodity,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_drop_up, color: AppColors.textPrimary, size: 20),
                          Icon(Icons.arrow_drop_down, color: AppColors.textPrimary, size: 20),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Price Alert Info Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      // Price Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: AppColors.primary,
                        alignment: Alignment.center,
                        child: const Text(
                          'Price',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              '5008.15',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _priceController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade400),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade400),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications, color: Colors.white),
                              label: const Text('SET ALERT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
