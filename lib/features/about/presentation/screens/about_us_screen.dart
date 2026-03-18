import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/diamond_pattern_painter.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'About Us',
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
          
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                _buildAboutText(
                  'Suvidhi Jewelex LLP is most reputed Bullion Dealer in Gujarat.',
                ),
                _buildAboutText(
                  'Suvidhi Jewelex LLP is providing best quality Gold Bars and Silver Bars at most competitive price at Ahmedabad and other parts of Gujarat.',
                ),
                _buildAboutText(
                  'Suvidhi Jewelex LLP has emerged as a leader in Bullion Market through its rich experience, innovation, creativity, trust and best customer relations.',
                ),
                _buildAboutText(
                  'Suvidhi Jewelex LLP is now equipped with latest technology to give Online Order Booking Services to their customers.',
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }
}
