import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class KYCReviewStep extends StatelessWidget {
  final VoidCallback onContinue;
  const KYCReviewStep({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review Your Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Confirm everything is correct before submitting',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.silverLight),
            ),
            child: Column(
              children: [
                _buildReviewRow('Name', 'Tushar Borgaonkar'),
                _buildDivider(),
                _buildReviewRow('Mobile', '+91 9XXXXXXXXX'),
                _buildDivider(),
                _buildReviewRow('PAN', 'ABCDE1234F'),
                _buildDivider(),
                _buildReviewRow('Aadhaar', 'XXXX XXXX 1234'),
              ],
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text('Submit Verification',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14)),
          Text(value,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Divider(height: 1, color: AppColors.silverLight),
      );
}
