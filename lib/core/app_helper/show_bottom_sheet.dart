import 'package:flutter/material.dart';

import '../style/app_colors.dart';

Future<void> showCustomBottomSheet(BuildContext context, Widget widget) async {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(24),
    )),
    builder: (context) {
      return widget;
    },
  );
}
