import 'package:attendance/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_images.dart';

class ProfileItemCard extends StatelessWidget {
  const ProfileItemCard({
    super.key,
    this.isEditable = false,
    required this.text,
    this.onEditTap,
  });

  final bool isEditable;
  final Function()? onEditTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Divider(
                color: isEditable ? Colors.black : null,
              ),
            ],
          ),
        ),
        if (isEditable)
          const SizedBox(
            width: 20,
          ),
        if (isEditable)
          GestureDetector(
            onTap: onEditTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8)),
              child: SvgPicture.asset(
                AppImages.edit,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
