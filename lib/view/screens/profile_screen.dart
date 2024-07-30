import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_size.dart';
import '../../core/style/app_colors.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Mohamed Osama',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: (){},
                    child: SvgPicture.asset(AppImages.edit),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'mossama370@gmail.com',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
          const SizedBox(height: 50),
          CustomButton(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.logOut),
                const SizedBox(width: 10),
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: AppSize.textScale(context, 16),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
            ],
      ),
    );
  }
}
