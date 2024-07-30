import 'package:attendance/controller/attendance/attendance_cubit.dart';
import 'package:attendance/core/app_helper/app_navigator.dart';
import 'package:attendance/core/custom_widgets/custom_text_button.dart';
import 'package:attendance/model/attendance_model.dart';
import 'package:attendance/view/screens/barcode_scanner_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cards/attendance_card.dart';

class TakeAttendanceScreen extends StatelessWidget {
  const TakeAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceCubit cubit = AttendanceCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: cubit.getAttendance(),
              builder: (context, snapshot) {
                return ListView.separated(
                  itemBuilder: (context, i) {
                    return AttendanceCard(
                      data: AttendanceModel.formMap(
                        snapshot.data!.docs[i].data() as Map<String, dynamic>,
                      ),
                    );
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: snapshot.data?.docs.length ?? 0,
                );
              }),
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
