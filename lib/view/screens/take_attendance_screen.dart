import 'package:attendance/core/app_helper/app_navigator.dart';
import 'package:attendance/core/custom_widgets/custom_text_button.dart';
import 'package:attendance/view/screens/barcode_scanner_screen.dart';
import 'package:flutter/material.dart';

import '../cards/attendance_card.dart';

class TakeAttendanceScreen extends StatelessWidget {
  const TakeAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Stack(
        children: [
          ListView.separated(
            itemBuilder: (context, i) {
              return const AttendanceCard();
            },
            separatorBuilder: (context, i) {
              return SizedBox(height: 8);
            },
            itemCount: 5,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextButton(
                text: 'Take Attendance',
                onTap: () =>
                    AppNavigator.push(context, const BarcodeScannerScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
