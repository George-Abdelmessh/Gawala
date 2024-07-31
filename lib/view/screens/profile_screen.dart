import 'package:attendance/controller/auth/auth_cubit.dart';
import 'package:attendance/controller/profile/profile_cubit.dart';
import 'package:attendance/core/app_helper/app_validators.dart';
import 'package:attendance/core/custom_widgets/custom_text_button.dart';
import 'package:attendance/core/custom_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_images.dart';
import '../../core/style/app_colors.dart';
import '../cards/profile_item_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _cubit = ProfileCubit.get(context);
  TextEditingController? _controller;
  late GlobalKey<FormState> _key;

  @override
  void initState() {
    super.initState();
    _cubit.isEditMode = false;
    _cubit.getUserData();
  }

  void _onSaveTap() {
    if (_key.currentState!.validate()) {
      _cubit.updateUserName(_controller!.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller!.dispose();
    }
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
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 140,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Builder(builder: (context) {
                    if (_cubit.isEditMode) {
                      _controller =
                          TextEditingController(text: _cubit.userData!.name);
                      _key = GlobalKey<FormState>();
                      return Form(
                        key: _key,
                        child: CustomTextFormField(
                          hint: '',
                          controller: _controller,
                          validator: (val) =>
                              AppValidators.required(value: val),
                        ),
                      );
                    }
                    return ProfileItemCard(
                      text: _cubit.userData!.name,
                      isEditable: true,
                      onEditTap: () {
                        _cubit.updateEditValue();
                      },
                    );
                  }),
                  const SizedBox(height: 8),
                  ProfileItemCard(
                    text: _cubit.userData!.email,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Joined At: ${DateFormat("dd-MM-yyyy").format(_cubit.userData!.createAt)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_cubit.userData!.lastUpdate != null)
                    Text(
                      'Last Update: ${DateFormat("dd-MM-yyyy").format(_cubit.userData!.lastUpdate!)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  const SizedBox(height: 18),
                  if (_cubit.isEditMode)
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextButton(
                            onTap: () => _onSaveTap(),
                            height: 45,
                            text: 'Save',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTextButton(
                            onTap: () => _cubit.updateEditValue(),
                            bgColor: AppColors.lightGrey,
                            height: 45,
                            textColor: AppColors.darkGrey.withOpacity(0.8),
                            text: 'Cancel',
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        AuthCubit.get(context).logout();
                      },
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
