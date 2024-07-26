import 'package:attendance/core/app_helper/app_navigator.dart';
import 'package:attendance/view/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_images.dart';
import '../../core/style/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      AppNavigator.pushRemove(context, const LoginScreen());
    });
    // autoLoginHandler();
  }

  // void autoLoginHandler() {
  //   final AuthCubit cubit = AuthCubit.get(context);
  //   if (CacheManager.getDate(key: TOKEN) != null) {
  //     cubit
  //         .login(
  //       params: AuthParams(
  //         email: cubit.decode(CacheManager.getDate(key: EMAIL)),
  //         password: cubit.decode(CacheManager.getDate(key: PASSWORD)),
  //       ),
  //     )
  //         .then((value) {
  //       AppNavigator.pushRemove(context, const HomeScreen());
  //     });
  //   } else {
  //     Future.delayed(const Duration(seconds: 2), () {
  //       AppNavigator.pushRemove(context, const OnBoardingScreen());
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          AppImages.splash,
        ),
      ),
    );
  }
}
