import 'package:flutter/material.dart';

import 'sub_team_screen.dart';
import '../../controller/team//teams_cubit.dart';
import '../../core/app_helper/app_navigator.dart';
import '../../core/style/app_colors.dart';
import '../../model/team_model.dart';
import '../cards/team_card.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  late final TeamsCubit _cubit = TeamsCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: StreamBuilder(
          stream: _cubit.getAllTeams(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, i) {
                    final Map<String, dynamic> data =
                        snapShot.data!.docs[i].data() as Map<String, dynamic>;
                    return TeamCard(
                      teamData: TeamModel.formMap(data),
                      onDeleteTap: () => _cubit.deleteTeam(teamId: data['id']),
                      onTap: () => AppNavigator.push(
                        context,
                        SubTeamScreen(
                          teamId: data['id'],
                          teamName: data['name'],
                        ),
                      ),
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
    );
  }
}
