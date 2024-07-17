import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data_source/end_points.dart';

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
        /// ToDo: handle with params
        data: {
          "name": name,
          "date_time": DateTime.now(),
          "sub_team_count": 0,
          "team_members_count": 0,
        },
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

  Future<void> addNewSubTeam({
    required final String id,
    required final String name,
  }) async {
    try {
      emit(LoadingState());
      final doc = FirebaseServices.firestore
          .collection(TEAMS_COLLECTION)
          .doc(id)
          .collection(SUB_TEAMS_COLLECTION)
          .doc();
      /// ToDo: handle with params
      doc.set({
        "id": doc.id,
        "name": name,
        "date_time": DateTime.now(),
        "sub_team_count": 0,
      });

      emit(SuccessState());
    } catch (e) {
      debugPrint('Error: $e');
      emit(ErrorState());
    }
  }
}
