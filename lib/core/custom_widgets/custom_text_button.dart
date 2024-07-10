import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.bgColor,
    required this.onTap,
    this.radius = 19,
    this.height = 50,
  });

  final String text;
  final Color? bgColor;
  final Function() onTap;
  final double radius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: height,
      minWidth: double.infinity,
      color: bgColor ?? AppColors.primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
