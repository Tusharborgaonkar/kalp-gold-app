import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import 'dart:ui';

class KYCAadhaarStep extends StatelessWidget {
  final VoidCallback onContinue;
  const KYCAadhaarStep({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aadhaar Verification',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Primary identity proof verification',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 32),
          _buildLabel('Enter Aadhaar Number'),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'XXXX XXXX XXXX',
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
            keyboardType: TextInputType.number,
            style: const TextStyle(
                fontWeight: FontWeight.w800, letterSpacing: 4),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Aadhaar Front'),
                    const SizedBox(height: 12),
                    _buildUploadBox(height: 120),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Aadhaar Back'),
                    const SizedBox(height: 12),
                    _buildUploadBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
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

  Widget _buildUploadBox({double height = 160}) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          CustomPaint(
            painter: _DottedBorderPainter(),
            child: Container(),
          ),
          Center(
            child: Icon(Icons.add_a_photo_outlined,
                size: 32, color: AppColors.primary.withOpacity(0.5)),
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
