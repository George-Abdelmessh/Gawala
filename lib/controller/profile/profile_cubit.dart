import 'package:attendance/core/data_source/end_points.dart';
import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:attendance/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? userData;

  Future<void> getUserData() async {
    try {
      emit(ProfileLoading());
      final String? id = _getUserId();
      if (id != null) {
        final data = await FirebaseServices.getSingleDoc(
          collection: USER_COLLECTION,
          id: id,
        );

        userData = UserModel.formMap(data.data() as Map<String, dynamic>);
        emit(ProfileSuccess());
      } else {
        emit(ProfileError());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ProfileError());
    }
  }

  String? _getUserId() {
    final user = FirebaseServices.getUserCredential();
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }
}
