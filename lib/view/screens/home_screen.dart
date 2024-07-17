import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controller/home/teams_cubit.dart';
import '../../core/app_helper/show_dialog.dart';
import '../../core/constants/app_images.dart';
import '../../core/style/app_colors.dart';
import '../../model/team_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/team_card.dart';
import '../widgets/add_team_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TeamsCubit _cubit = TeamsCubit.get(context);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'HomeScreen', image:  AppImages.carrotLogo),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPopupDialog(context, const AddTeamForm()),
        backgroundColor: AppColors.softOrange,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: StreamBuilder(
          stream: _cubit.getAllTeams(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, i) {
                    return TeamCard(
                      teamData: TeamModel.formMap(
                        snapShot.data!.docs[i].data() as Map<String, dynamic>,
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
      ),
    );
  }
}
