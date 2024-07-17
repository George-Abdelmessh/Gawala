import 'package:flutter/material.dart';

import '../../core/app_helper/show_dialog.dart';
import '../../core/style/app_colors.dart';
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
    return Scaffold(
      appBar: customAppBar(title: subTeamName),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPopupDialog(
          context,
          Placeholder(),
        ),
        backgroundColor: AppColors.softOrange,
        child: const Icon(Icons.add),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //   child: StreamBuilder(
      //     stream: cubit.getSubTeams(id),
      //     builder: (context, snapShot) {
      //       if (snapShot.hasData) {
      //         return ListView.separated(
      //             itemBuilder: (context, i) {
      //               final Map<String, dynamic> data =
      //               snapShot.data!.docs[i].data() as Map<String, dynamic>;
      //               return TeamCard(
      //                 teamData: TeamModel.formMap(data),
      //                 onDeleteTap: () => cubit.deleteSubTeam(
      //                   teamId: id,
      //                   subTeamId: data['id'],
      //                 ),
      //                 onTap: () {},
      //               );
      //             },
      //             separatorBuilder: (context, i) {
      //               return const SizedBox(height: 8);
      //             },
      //             itemCount: snapShot.data!.docs.length);
      //       }
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           color: AppColors.primaryColor,
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
