import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/style/app_colors.dart';

AppBar customAppBar({
  final String? image,
  required final String title,
}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (image != null)
          SvgPicture.asset(
            image,
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            width: 28,
            height: 28,
          ),
        if (image != null) const SizedBox(width: 8),
         Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
      ],
    ),
    centerTitle: true,
    leadingWidth: 0,
    leading: const SizedBox(width: 0,),
  );
}
