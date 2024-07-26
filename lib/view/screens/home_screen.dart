import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendance/core/style/app_colors.dart';

import '../../controller/nav_bar/nav_bar_cubit.dart';
import '../../controller/nav_bar/nav_bar_state.dart';
import '../../controller/team/teams_cubit.dart';
import '../../core/app_helper/show_dialog.dart';
import '../../core/constants/app_images.dart';
import '../widgets/add_team_form.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  late final TeamsCubit _cubit = TeamsCubit.get(context);

  final List<String> _titles = ['HomeScreen', 'SearchScreen', 'ProfileScreen', 'TakeAttendanceScreen'];

  @override
  Widget build(BuildContext context) {
    final NavBarCubit cubit = NavBarCubit.get(context);
    return Scaffold(
      appBar: customAppBar(title: _titles[cubit.currentIndex], image: AppImages.carrotLogo),
      floatingActionButton: cubit.currentIndex == 0
          ? FloatingActionButton(
        onPressed: () => showPopupDialog(
          context,
          AddTeamForm(
            title: "Add New Team",
            onAdd: (String name) => _cubit.addNewTeam(name: name),
          ),
        ),
        backgroundColor: AppColors.softOrange,
        child: const Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: AppColors.primaryColor,
            currentIndex: cubit.currentIndex,
            unselectedItemColor: AppColors.black,
            onTap: (index) {
              cubit.changeNavBarIndex(index);
              setState(() {}); // Trigger a rebuild to update the app bar title
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_rounded),
                label: 'Take attendance',
              ),
            ],
          );
        },
      ),
      body: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          return SafeArea(
            child: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
