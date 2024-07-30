import 'package:flutter/material.dart';

import '../../core/constants/app_size.dart';
import '../../core/style/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  final Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColors.antiFlashWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(19)),
      ),
      onPressed: onTap,
      minWidth: double.infinity,
      height: 67,
      child: child,
    );
  }
}
