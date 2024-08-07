import 'dart:typed_data';

import 'package:attendance/core/app_helper/app_toast.dart';
import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:attendance/view/widgets/qr_screnshot_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

import '../../core/app_helper/app_permissions.dart';
import '../../core/data_source/end_points.dart';
import '../../params/team_member_params.dart';

part 'team_member_state.dart';

class TeamMemberCubit extends Cubit<TeamMemberState> {
  TeamMemberCubit() : super(TeamMemberInitial());

  static TeamMemberCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> addTeamMember({
    required final BuildContext context,
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

      await qrScreenshot(context, doc.id, finalParams.name);
      emit(TeamMemberSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(TeamMemberError());
    }
  }

  Future<void> deleteTeamMember({
    required final String teamId,
    required final String subTeamId,
    required final String memberId,
  }) async {
    try {
      emit(TeamMemberLoading());
      await FirebaseServices.firestore
          .collection(TEAMS_COLLECTION)
          .doc(teamId)
          .collection(SUB_TEAMS_COLLECTION)
          .doc(subTeamId)
          .collection(TEAM_MEMBERS_COLLECTION)
          .doc(memberId)
          .delete();
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

  Future<void> qrScreenshot(
    BuildContext context,
    String memberId,
    String memberName,
  ) async {
    try {
      final ScreenshotController screenshotController = ScreenshotController();
      await screenshotController
          .captureFromWidget(
        InheritedTheme.captureAll(
            context,
            Material(
              child: QrScreenshotWidget(
                id: memberId,
                name: memberName,
              ),
            )),
        delay: const Duration(seconds: 1),
      )
          .then(
        (Uint8List? image) async {
          if (image != null) {
            await requestPermissions();
            await _saveLocalImage(image);
          }
          showSuccessToast('Done');
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _saveLocalImage(Uint8List image) async {
    try {
      await ImageGallerySaver.saveImage(image);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
