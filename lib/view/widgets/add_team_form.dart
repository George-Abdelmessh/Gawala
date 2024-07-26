import 'package:flutter/material.dart';

import '../../core/app_helper/app_validators.dart';
import '../../core/custom_widgets/custom_text_button.dart';
import '../../core/custom_widgets/custom_text_form_field.dart';
import '../../core/style/app_colors.dart';

class AddTeamForm extends StatefulWidget {
  const AddTeamForm({super.key, required this.title, required this.onAdd});

  final String title;
  final Function(String name) onAdd;

  @override
  State<AddTeamForm> createState() => _AddTeamFormState();
}

class _AddTeamFormState extends State<AddTeamForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAddTap() {
    if (_key.currentState!.validate()) {
      Navigator.pop(context);
      widget.onAdd(_controller.text);
      // _cubit.addNewTeam(name: _controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomTextFormField(
            label: 'Team Name',
            controller: _controller,
            validator: (val) => AppValidators.required(value: val),
            hint: '',
          ),
          const SizedBox(
            height: 30,
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
    );
  }
}
