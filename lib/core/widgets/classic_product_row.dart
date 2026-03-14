import 'package:flutter/material.dart';
import '../constants/constants.dart';

class ClassicProductRow extends StatelessWidget {
  final String name;
  final String price;
  final bool isActive;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const ClassicProductRow({
    super.key,
    required this.name,
    required this.price,
    this.isActive = true,
    this.onTap,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.background, width: 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                price,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              isActive ? Icons.check_circle : Icons.remove_circle,
              color: isActive ? AppColors.success : AppColors.textSecondary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
