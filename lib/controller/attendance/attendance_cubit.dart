import 'package:attendance/core/data_source/end_points.dart';
import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  static AttendanceCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> takeAttendance(String? value) async {
    try {
      if (value != null) {
        // 'user_id:______,team_id:____,sub_team_id:_____';
        final List<String> ids = value.split(','); // 3 index
        // user_id:______,
        // team_id:____,
        // sub_team_id:_____
        final Map<String, dynamic> finalData = {};

        for (String pair in ids) {
          final List<String> pairValues = pair.split(':'); // ["key", "value"]
          finalData[pairValues[0]] = pairValues[1];
        }

        finalData['date_time'] = DateTime.now();

        await FirebaseServices.addData(
          collection: ATTENDANCE_COLLECTION,
          data: finalData,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
