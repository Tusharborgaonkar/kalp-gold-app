import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class KYCIntroStep extends StatelessWidget {
  final VoidCallback onContinue;
  const KYCIntroStep({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Complete Your Verification',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'To buy gold or silver, we need to verify your identity as per financial regulations.',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          _buildCheckItem('PAN Card'),
          _buildCheckItem('Aadhaar Card'),
          _buildCheckItem('Personal Details'),
          _buildCheckItem('Photo Verification'),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_outlined, color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Takes less than 2 minutes',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text('Start Verification',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
