import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/diamond_pattern_painter.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Bank Details',
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
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Bank Logo Area
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      // ICICI Bank Logo Placeholder/Simulation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE31E24), // ICICI Red
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.info_outline, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'ICICI Bank',
                            style: TextStyle(
                              color: Color(0xFF003366), // ICICI Blue
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8),
                      
                      // Bank Details Rows
                      _buildDetailRow('NAME :', 'SUVDIHI JEWELEX LLP'),
                      _buildDetailRow('A/C NO :', '777705046615'),
                      _buildDetailRow('IFSC CODE :', 'ICIC0007507 (ALL ARE ZEROS)'),
                      _buildDetailRow('BRANCH :', 'KHOKHRA BRANCH'),
                      _buildDetailRow('BANK :', 'ICICI BANK'),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(thickness: 0.5),
        ],
      ),
    );
  }
}
