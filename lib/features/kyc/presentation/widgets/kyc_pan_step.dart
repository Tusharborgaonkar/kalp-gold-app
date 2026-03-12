import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class KYCPanStep extends StatelessWidget {
  final VoidCallback onContinue;
  const KYCPanStep({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PAN Card Verification',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We need this for tax and regulation compliance',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 32),
          _buildLabel('Enter PAN Number'),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'ABCDE1234F',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.silverLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.silverLight),
              ),
            ),
            textCapitalization: TextCapitalization.characters,
            style: const TextStyle(
                fontWeight: FontWeight.w800, letterSpacing: 1.5),
          ),
          const SizedBox(height: 32),
          _buildLabel('Upload PAN Card Image'),
          const SizedBox(height: 12),
          _buildUploadBox(),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.silverLight, style: BorderStyle.none),
      ),
      child: Stack(
        children: [
          // Dotted border simulator
          CustomPaint(
            painter: _DottedBorderPainter(),
            child: Container(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo_outlined,
                    size: 40, color: AppColors.primary.withOpacity(0.5)),
                const SizedBox(height: 12),
                const Text(
                  'Upload Photo',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'JPG or PNG, max 5MB',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary.withOpacity(0.6),
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

class _DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.silverLight
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromLTRBR(
        0, 0, size.width, size.height, const Radius.circular(20));
    final Path path = Path()..addRRect(rrect);

    const double dashWidth = 8;
    const double dashSpace = 4;
    double distance = 0;
    for (PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        canvas.drawPath(
          measurePath.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

