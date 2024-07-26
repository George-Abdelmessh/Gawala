import 'package:attendance/controller/team_member/team_member_cubit.dart';
import 'package:flutter/material.dart';

import '../../core/app_helper/show_dialog.dart';
import '../../core/style/app_colors.dart';
import '../../model/team_member_model.dart';
import '../cards/team_member_card.dart';
import '../widgets/add_team_member_form_widget.dart';
import '../widgets/custom_app_bar.dart';

class TeamMembersScreen extends StatelessWidget {
  const TeamMembersScreen({
    super.key,
    required this.teamId,
    required this.subTeamId,
    required this.subTeamName,
  });

  final String teamId;
  final String subTeamId;
  final String subTeamName;

  @override
  Widget build(BuildContext context) {
    final TeamMemberCubit cubit = TeamMemberCubit.get(context);
    return Scaffold(
      appBar: customAppBar(title: subTeamName),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPopupDialog(
          context,
          AddTeamMemberFormWidget(
            subTeamId: subTeamId,
            teamId: teamId,
          ),
        ),
        backgroundColor: AppColors.softOrange,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: StreamBuilder(
          stream: cubit.getTeamMember(teamId: teamId, subTeamId: subTeamId),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, i) {
                    final Map<String, dynamic> data =
                        snapShot.data!.docs[i].data() as Map<String, dynamic>;
                    return TeamMemberCard(
                      data: TeamMemberModel.formMap(data),
                    );
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: snapShot.data!.docs.length);
            }
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
