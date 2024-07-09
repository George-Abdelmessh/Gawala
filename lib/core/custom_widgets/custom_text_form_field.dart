import 'package:flutter/material.dart';

import '../constants/app_size.dart';
import '../style/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.controller,
    this.secureText = false,
    this.borderColor = AppColors.primaryColor,
    this.prefix,
    this.suffix,
    this.fillColor,
    this.isFilled,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputType = TextInputType.text,
    this.label,
  });

  final String hint;
  final String? label;
  final TextEditingController? controller;
  final bool secureText;
  final Color borderColor;
  final Color? fillColor;
  final bool? isFilled;
  final Widget? prefix;
  final Widget? suffix;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final int minLines;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
           Text(
            label!,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.mediumGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        TextFormField(
          controller: controller,
          validator: validator ?? (val) => null,
          obscureText: secureText,
          maxLines: maxLines,
          minLines: minLines,
          keyboardType: textInputType,
          decoration: InputDecoration(
            constraints: minLines > 1
                ? null
                : BoxConstraints(
                    maxHeight: AppSize.heightScale(context, 40),
                  ),
            fillColor: fillColor,
            filled: isFilled,
            // label: Icon(Icons.access_alarms),
            // labelText: 'UserName',
            prefixIcon: prefix,
            prefixIconColor: Colors.grey,
            suffixIcon: suffix,
            // prefixIconConstraints: BoxConstraints(
            //   maxHeight: 30,
            //   minWidth: 120
            // ),

            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black),
            // errorBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Colors.red,
            //   ),
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(30),
            //   ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: borderColor,
            //   ),
            //   borderRadius: const BorderRadius.all(
            //     Radius.circular(30),
            //   ),
            // ),
            // disabledBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.grey),
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(30),
            //   ),
            // ),
            // focusedBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Colors.black,
            //   ),
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(30),
            //   ),
            // ),
            //---------
            // border: const OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.red),
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(30),
            //   ),
            // ),
          ),
          style: const TextStyle(
            height: 1,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
