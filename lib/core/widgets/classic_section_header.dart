import 'package:flutter/material.dart';
import '../constants/constants.dart';

class ClassicSectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback? onActionPressed;
  final Color backgroundColor;
  final Color textColor;

  const ClassicSectionHeader({
    super.key,
    required this.title,
    this.actionLabel = '',
    this.onActionPressed,
    this.backgroundColor = AppColors.goldLight,
    this.textColor = AppColors.primaryDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          if (actionLabel.isNotEmpty)
            InkWell(
              onTap: onActionPressed,
              child: Text(
                actionLabel,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}
