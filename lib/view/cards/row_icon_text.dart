import 'package:attendance/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class RowIconText extends StatelessWidget {
  const RowIconText({
    super.key,
    required this.text,
    required this.icon,
    this.textStyle,
    this.space = 8,
     this.iconColor,
  });

  final String text;
  final TextStyle? textStyle;
  final IconData icon;
  final Color? iconColor;
  final double space;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: iconColor?? AppColors.lightGrey,
        ),
        SizedBox(width: space),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
