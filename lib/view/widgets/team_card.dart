import 'package:attendance/core/app_helper/app_navigator.dart';
import 'package:attendance/view/screens/sub_team_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/style/app_colors.dart';
import '../../model/team_model.dart';
import '../cards/row_icon_text.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({super.key, required this.teamData});

  final TeamModel teamData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.push(
          context,
          SubTeamScreen(
            id: teamData.id,
          )),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.green),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RowIconText(
                        icon: Icons.abc,
                        text: teamData.name,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RowIconText(
                        icon: Icons.account_tree,
                        text: teamData.subTeamCount.toString(),
                        space: 2,
                        iconColor: AppColors.softOrange,
                        textStyle: const TextStyle(
                            fontSize: 14, color: AppColors.softOrange),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RowIconText(
                        icon: Icons.person,
                        text: teamData.teamMembersCount.toString(),
                        space: 2,
                        iconColor: AppColors.softOrange,
                        textStyle: const TextStyle(
                            fontSize: 14, color: AppColors.softOrange),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      RowIconText(
                        icon: Icons.timelapse_sharp,
                        text: DateFormat("dd/MM/yyyy - hh:mm")
                            .format(teamData.dateTime),
                        textStyle: const TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        /// ToDo: handle delete method
                        onTap: () {},
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // const Spacer(),
            const Icon(
              Icons.arrow_forward,
              size: 18,
              color: AppColors.green,
            )
          ],
        ),
      ),
    );
  }
}
