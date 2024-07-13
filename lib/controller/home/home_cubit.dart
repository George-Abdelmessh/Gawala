import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data_source/end_points.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> addNewTeam({
    required final String name,
  }) async {
    try {
      emit(HomeLoadingState());
      await FirebaseServices.addData(
        collection: TEAMS_COLLECTION,
        data: {
          "name": name,
          "date_time": DateTime.now(),
          "sub_team_count": 0,
        },
      );
      emit(HomeSuccessState());
    } catch (e) {
      debugPrint('Error: $e');
      emit(HomeErrorState());
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
      emit(HomeLoadingState());
      final doc = FirebaseServices.firestore
          .collection(TEAMS_COLLECTION)
          .doc(id)
          .collection(SUB_TEAMS_COLLECTION)
          .doc();

      doc.set({
        "id": doc.id,
        "name": name,
        "date_time": DateTime.now(),
        "sub_team_count": 0,
      });

      emit(HomeSuccessState());
    } catch (e) {
      debugPrint('Error: $e');
      emit(HomeErrorState());
    }
  }
}
