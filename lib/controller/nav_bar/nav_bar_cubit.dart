import 'package:attendance/view/screens/profile_screen.dart';
import 'package:attendance/view/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view/screens/home_screen_content.dart';
import '../../view/screens/take_attendance_screen.dart';
import 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit(): super(NavBarInitState());

  static NavBarCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    HomeScreenContent(),
    SearchScreen(),
    TakeAttendanceScreen(),
    ProfileScreen(),
  ];

  void changeNavBarIndex (int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

}