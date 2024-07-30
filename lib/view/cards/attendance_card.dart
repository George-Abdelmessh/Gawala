import 'package:flutter/material.dart';

import '../../core/style/app_colors.dart';
import 'row_icon_text.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.green),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowIconText(
            icon: Icons.accessibility,
            text: 'name',
            space: 2,
            iconColor: AppColors.softOrange,
            textStyle: TextStyle(
              fontSize: 14,
              color: AppColors.softOrange,
            ),
          ),
          SizedBox(height: 8),
          RowIconText(
            icon: Icons.account_balance_wallet_outlined,
            text: 'team',
            space: 2,
            textStyle: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          RowIconText(
            icon: Icons.account_tree_sharp,
            text: 'sub team',
            space: 2,
            textStyle: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          RowIconText(
            icon: Icons.access_time_outlined,
            text: 'date time',
            space: 2,
            textStyle: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
