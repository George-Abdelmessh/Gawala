import 'package:attendance/controller/home/home_cubit.dart';
import 'package:flutter/material.dart';

import '../../core/app_helper/show_dialog.dart';
import '../../core/style/app_colors.dart';
import '../widgets/custom_app_bar.dart';

class SubTeamScreen extends StatelessWidget {
  const SubTeamScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: customAppBar(title: 'Sub Team Screen'),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => showPopupDialog(context, const Placeholder()),
        onPressed: () {
          HomeCubit.get(context).addNewSubTeam(id: id, name: 'Jac Sub Team');
        },
        backgroundColor: AppColors.softOrange,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
