import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class MetalSparkline extends StatelessWidget {
  final Color color;
  final List<double> data;

  const MetalSparkline({
    super.key,
    required this.color,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 80,
      child: CustomPaint(
        painter: _SparklinePainter(color: color, data: data),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final Color color;
  final List<double> data;

  _SparklinePainter({required this.color, required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final double stepX = size.width / (data.length - 1);
    final double max = data.reduce((a, b) => a > b ? a : b);
    final double min = data.reduce((a, b) => a < b ? a : b);
    final double range = max - min == 0 ? 1 : max - min;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - ((data[i] - min) / range * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Shadow/Area below
    final areaPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(areaPath, areaPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
