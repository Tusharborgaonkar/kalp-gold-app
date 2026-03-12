import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class KYCDetailsStep extends StatelessWidget {
  final VoidCallback onContinue;
  const KYCDetailsStep({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Basic information to get started',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 32),
          _buildTextField('Full Name', Icons.person_outline_rounded),
          const SizedBox(height: 20),
          _buildTextField('Email Address', Icons.email_outlined),
          const SizedBox(height: 20),
          _buildTextField('Mobile Number', Icons.phone_android_rounded),
          const SizedBox(height: 20),
          _buildTextField('GST Number (Optional)', Icons.business_outlined),
          const SizedBox(height: 48),
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
              child: const Text('Continue',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.silverLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.silverLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
