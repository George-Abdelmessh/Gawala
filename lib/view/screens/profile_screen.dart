import 'package:attendance/controller/auth/auth_cubit.dart';
import 'package:attendance/controller/profile/profile_cubit.dart';
import 'package:attendance/core/app_helper/app_navigator.dart';
import 'package:attendance/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_images.dart';
import '../../core/style/app_colors.dart';
import '../cards/profile_item_card.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _cubit = ProfileCubit.get(context);

  @override
  void initState() {
    super.initState();
    _cubit.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                  size: 100,
                ),
              ),
              const SizedBox(height: 20),
              ProfileItemCard(
                text: _cubit.userData!.id,
              ),
              const SizedBox(height: 8),
              ProfileItemCard(
                text: _cubit.userData!.name,
                isEditable: true,
                onEditTap: () {},
              ),
              const SizedBox(height: 8),
              ProfileItemCard(
                text: _cubit.userData!.email,
              ),
              const SizedBox(height: 8),
              Text(
                'Joined At: ${DateFormat("dd/MM/yyyy - hh:mm").format(_cubit.userData!.createAt)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: CustomButton(
                  onTap: () {
                    AuthCubit.get(context).logout();
                    AppNavigator.pushRemove(context, const LoginScreen());
                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppImages.logOut,
                          height: 14,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Log Out',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            // fontSize: AppSize.textScale(context, 16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
