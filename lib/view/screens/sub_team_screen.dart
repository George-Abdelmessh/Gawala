import 'package:attendance/controller/home/teams_cubit.dart';
import 'package:flutter/material.dart';

import '../../core/app_helper/show_dialog.dart';
import '../../core/style/app_colors.dart';
import '../../model/team_model.dart';
import '../widgets/add_team_form.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/team_card.dart';

class SubTeamScreen extends StatelessWidget {
  const SubTeamScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final TeamsCubit cubit = TeamsCubit.get(context);
    return Scaffold(
      appBar: customAppBar(title: 'Sub Team Screen'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPopupDialog(
          context,
          AddTeamForm(
            title: "Add Sub-Team",
            onAdd: (String name) => cubit.addNewSubTeam(
              id: id,
              name: name,
            ),
          ),
        ),
        backgroundColor: AppColors.softOrange,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: StreamBuilder(
          stream: cubit.getSubTeams(id),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, i) {
                    final Map<String, dynamic> data =
                        snapShot.data!.docs[i].data() as Map<String, dynamic>;
                    return TeamCard(
                      teamData: TeamModel.formMap(data),
                      onDeleteTap: () => cubit.deleteSubTeam(
                        teamId: id,
                        subTeamId: data['id'],
                      ),
                      onTap: () {},
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
