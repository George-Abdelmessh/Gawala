import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../params/team_params.dart';
import '../../core/data_source/end_points.dart';
import '../../core/data_source/firebase/firebase_services.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit() : super(InitialState());

  static TeamsCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> addNewTeam({
    required final String name,
  }) async {
    try {
      emit(LoadingState());
      await FirebaseServices.addData(
        collection: TEAMS_COLLECTION,
        data: TeamParams(
          name: name,
          dateTime: DateTime.now(),
          subTeamCount: 0,
          teamMembersCount: 0,
        ).toJson(),
      );
      emit(SuccessState());
    } catch (e) {
      debugPrint('Error: $e');
      emit(ErrorState());
    }
  }

  Stream<QuerySnapshot>? getAllTeams() {
    try {
      return FirebaseServices.getDataStream(
        collection: TEAMS_COLLECTION,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Stream<QuerySnapshot>? getSubTeams(String docId) {
    try {
      return FirebaseServices.firestore
          .collection(TEAMS_COLLECTION)
          .doc(docId)
          .collection(SUB_TEAMS_COLLECTION)
          .snapshots();
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<void> addNewSubTeam({
    required final String id,
    required final String name,
  }) async {
    try {
      emit(LoadingState());
      final parentDoc =
          FirebaseServices.firestore.collection(TEAMS_COLLECTION).doc(id);

      final subDoc = parentDoc.collection(SUB_TEAMS_COLLECTION).doc();

      subDoc.set(
        TeamParams(
          id: subDoc.id,
          name: name,
          dateTime: DateTime.now(),
          teamMembersCount: 0,
        ).toJson(),
      );

      _updateSubTeamCount(id);

      emit(SuccessState());
    } catch (e) {
      debugPrint('Error: $e');
      emit(ErrorState());
    }
  }

  Future<void> _updateSubTeamCount(String id) async {
    final parentDoc =
        FirebaseServices.firestore.collection(TEAMS_COLLECTION).doc(id);
    final list = await parentDoc.collection(SUB_TEAMS_COLLECTION).get();
    parentDoc.update({
      "sub_team_count": list.docs.length,
    });
  }

  Future<void> deleteTeam({
    required final String teamId,
  }) async {
    try {
      emit(LoadingState());
      await FirebaseServices.deleteDoc(
        collection: TEAMS_COLLECTION,
        id: teamId,
      );
      emit(SuccessState());
    } catch (e) {
      debugPrint('Error: $e');
      emit(ErrorState());
    }
  }

  Future<void> deleteSubTeam({
    required final String teamId,
    required final String subTeamId,
  }) async {
    try {
      emit(LoadingState());
      await FirebaseServices.firestore
          .collection(TEAMS_COLLECTION)
          .doc(teamId)
          .collection(SUB_TEAMS_COLLECTION)
          .doc(subTeamId)
          .delete();

      _updateSubTeamCount(teamId);

      emit(SuccessState());
    } catch (e) {
      debugPrint('Error: $e');
      emit(ErrorState());
    }
  }
}
