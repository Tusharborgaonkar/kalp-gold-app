import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/diamond_pattern_painter.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'News',
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
          
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildNewsCard(
                title: 'Gold prices going nowhere fast as U.S. pending home sales rise 1.8%',
                timestamp: 'Tue, 17 Mar 2026 10:30:39 EDT',
              ),
              _buildNewsCard(
                title: 'Gold and silver getting comfortable around key support levels',
                timestamp: 'Tue, 17 Mar 2026 09:23:16 EDT',
              ),
              _buildNewsCard(
                title: 'Gold is still set to gain 20% above current prices in 2026 - UBS',
                timestamp: 'Mon, 16 Mar 2026 14:33:11 EDT',
              ),
              _buildNewsCard(
                title: 'Gold, silver down as risk appetite improves, crude sinks',
                timestamp: 'Mon, 16 Mar 2026 11:36:01 EDT',
              ),
              _buildNewsCard(
                title: 'Gold price holding support above \$5,000 after Empire State Survey drops to -0.2 in March',
                timestamp: 'Mon, 16 Mar 2026 09:15:45 EDT',
              ),
              _buildNewsCard(
                title: 'Global markets brace for impact as major central banks signal potential rate cuts later this year',
                timestamp: 'Sun, 15 Mar 2026 18:42:10 EDT',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard({required String title, required String timestamp}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ),
          // Footer Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            color: AppColors.primary,
            alignment: Alignment.centerRight,
            child: Text(
              timestamp,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
