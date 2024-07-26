import 'package:attendance/core/data_source/end_points.dart';
import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  static AttendanceCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> takeAttendance(String? id) async {
    try {
      if (id != null) {
        await FirebaseServices.addData(
            collection: ATTENDANCE_COLLECTION,
            data: {
              'user_id': id,
              'date_time': DateTime.now(),
            });
      }
    } catch (e) {
      print(e);
    }
  }
}
