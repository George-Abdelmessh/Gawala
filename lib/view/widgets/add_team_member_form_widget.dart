import 'package:attendance/controller/team_member/team_member_cubit.dart';
import 'package:attendance/core/app_helper/app_validators.dart';
import 'package:attendance/core/custom_widgets/custom_text_form_field.dart';
import 'package:attendance/params/team_member_params.dart';
import 'package:flutter/material.dart';

import '../../core/custom_widgets/custom_text_button.dart';
import '../../core/style/app_colors.dart';

class AddTeamMemberFormWidget extends StatefulWidget {
  const AddTeamMemberFormWidget({
    super.key,
    required this.teamId,
    required this.subTeamId,
  });

  final String teamId;
  final String subTeamId;

  @override
  State<AddTeamMemberFormWidget> createState() =>
      _AddTeamMemberFormWidgetState();
}

class _AddTeamMemberFormWidgetState extends State<AddTeamMemberFormWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  Future<void> _onAddTap() async {
    if (_key.currentState!.validate()) {
      await TeamMemberCubit.get(context)
          .addTeamMember(
        teamId: widget.teamId,
        subTeamId: widget.subTeamId,
        params: TeamMemberParams(
          name: _nameController.text,
          phone: _phoneController.text,
          position: _positionController.text,
          age: int.parse(_ageController.text),
          team: widget.teamId,
          subTeam: widget.subTeamId,
        ),
      ).then((val) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Team Member",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            CustomTextFormField(
              label: 'Name',
              hint: 'Ex.George...',
              controller: _nameController,
              validator: (val) => AppValidators.required(value: val),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              label: 'Position',
              hint: 'Ex.Team Leader...',
              controller: _positionController,
              validator: (val) => AppValidators.required(value: val),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              label: 'Phone Number',
              hint: '010258.....',
              controller: _phoneController,
              textInputType: TextInputType.phone,
              validator: (val) => AppValidators.required(value: val),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              label: 'Age',
              hint: 'Ex.28',
              controller: _ageController,
              textInputType: TextInputType.number,
              validator: (val) => AppValidators.required(value: val),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextButton(
                text: 'Add',
                height: 40,
                onTap: () => _onAddTap(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
