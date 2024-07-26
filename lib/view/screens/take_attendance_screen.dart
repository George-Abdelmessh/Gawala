import 'package:attendance/core/app_helper/app_navigator.dart';
import 'package:attendance/core/custom_widgets/custom_text_button.dart';
import 'package:attendance/view/screens/barcode_scanner_screen.dart';
import 'package:flutter/material.dart';

class TakeAttendanceScreen extends StatelessWidget {
  const TakeAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Center(
        child: CustomTextButton(
          text: 'Take Attendance',
          onTap: () => AppNavigator.push(context, const BarcodeScannerScreen()),
        ),
      ),
    );
  }
}
