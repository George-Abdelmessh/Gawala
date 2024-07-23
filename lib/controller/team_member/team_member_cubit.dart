import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data_source/end_points.dart';
import '../../params/team_member_params.dart';

part 'team_member_state.dart';

class TeamMemberCubit extends Cubit<TeamMemberState> {
  TeamMemberCubit() : super(TeamMemberInitial());

  static TeamMemberCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> addTeamMember({
    required final String teamId,
    required final String subTeamId,
    required final TeamMemberParams params,
  }) async {
    try {
      emit(TeamMemberLoading());
      final doc = FirebaseServices.firestore
          .collection(TEAMS_COLLECTION)
          .doc(teamId)
          .collection(SUB_TEAMS_COLLECTION)
          .doc(subTeamId)
          .collection(TEAM_MEMBERS_COLLECTION)
          .doc();

      final TeamMemberParams finalParams = params;
      finalParams.id = doc.id;
      doc.set(finalParams.toJson());

      emit(TeamMemberSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(TeamMemberError());
    }
  }

  Stream<QuerySnapshot>? getTeamMember({
    required final String teamId,
    required final String subTeamId,
  }) {
    try {
      return FirebaseServices.firestore
          .collection(TEAMS_COLLECTION)
          .doc(teamId)
          .collection(SUB_TEAMS_COLLECTION)
          .doc(subTeamId)
          .collection(TEAM_MEMBERS_COLLECTION)
          .snapshots();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
