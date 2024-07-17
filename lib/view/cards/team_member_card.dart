import 'package:attendance/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/style/app_colors.dart';
import 'row_icon_text.dart';

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 178,
          padding: const EdgeInsets.only(
            top: 18,
            right: 10,
            left: 10,
            bottom: 10,
          ),
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.green),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowIconText(
                    icon: Icons.abc,
                    text: 'teamData.name',
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  RowIconText(
                    icon: Icons.phone,
                    iconColor: AppColors.softOrange,
                    text: '01062374445',
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.softOrange,
                    ),
                  ),
                  SizedBox(height: 8),
                  RowIconText(
                    icon: Icons.accessibility_sharp,
                    text: '25',
                    textStyle:
                        TextStyle(fontSize: 16, color: AppColors.lightGrey),
                  ),
                  SizedBox(height: 8),
                  RowIconText(
                    icon: Icons.account_box,
                    text: 'Geo Team',
                    textStyle:
                        TextStyle(fontSize: 16, color: AppColors.lightGrey),
                  ),
                  SizedBox(height: 8),
                  RowIconText(
                    icon: Icons.timelapse_sharp,
                    text: '7/7/2024 05:30',
                    textStyle:
                        TextStyle(fontSize: 16, color: AppColors.lightGrey),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    AppImages.qr,
                    width: 60,
                    height: 60,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.lightGrey.withOpacity(0.3),
                      ),
                      child: const Icon(
                        Icons.delete_forever,
                        size: 19,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),

        ///
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor),
            child: const Text(
              'Team Leader',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
