import 'package:attendance/core/data_source/end_points.dart';
import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<QuerySnapshot>? getAttendance() {
    try {
      return FirebaseServices.getDataStream(
        collection: ATTENDANCE_COLLECTION,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<Map<String, String>?> getMemberData({
    required String teamId,
    required String subTeamId,
    required String memberId,
  }) async {
    try {
      final Map<String, String> memberData = {};
      memberData['team_name'] = await _getTeamName(teamId);
      memberData['sub_team_name'] = await _getSubTeamName(teamId, subTeamId);
      memberData['member_name'] =
          await _getTeamMemberName(teamId, subTeamId, memberId);

      emit(AttendanceSuccess());
      return memberData;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String> _getTeamName(teamId) async {
    final teamData = await FirebaseServices.firestore
        .collection(TEAMS_COLLECTION)
        .doc(teamId)
        .get();
    return teamData.data()!['name'];
  }

  Future<String> _getSubTeamName(teamId, subTeamId) async {
    final subTeamData = await FirebaseServices.firestore
        .collection(TEAMS_COLLECTION)
        .doc(teamId)
        .collection(SUB_TEAMS_COLLECTION)
        .doc(subTeamId)
        .get();

    return subTeamData.data()!['name'];
  }

  Future<String> _getTeamMemberName(teamId, subTeamId, memberId) async {
    final teamMemberData = await FirebaseServices.firestore
        .collection(TEAMS_COLLECTION)
        .doc(teamId)
        .collection(SUB_TEAMS_COLLECTION)
        .doc(subTeamId)
        .collection(TEAM_MEMBERS_COLLECTION)
        .doc(memberId)
        .get();

    return teamMemberData.data()!['name'];
  }
}
