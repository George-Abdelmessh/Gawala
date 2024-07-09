import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data_source/firebase/firebase_services.dart';
import '../../core/app_helper/app_toast.dart';
import '../../core/data_source/end_points.dart';
import '../../params/auth_params.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  // String? userName;

  /// SignIn Method
  Future<void> signIn({
    required final AuthParams params,
  }) async {
    try {
      emit(AuthLoadingState());
      final User? user = await FirebaseServices.signIn(
        params.email,
        params.password!,
      );

      if (user != null) {
        showSuccessToast('Welcome back');
        emit(AuthSuccessState());
      } else {
        showErrorToast('Plz heck your email and password, and try again!');
        emit(AuthErrorState(
            'plz Check your email and password, and try again!'));
      }
    } catch (e) {
      showErrorToast(e.toString());
      emit(AuthErrorState(e.toString()));
    }
  }

  /// Signup Method
  Future<void> signup({
    required final AuthParams params,
  }) async {
    try {
      emit(AuthLoadingState());
      final User? user = await FirebaseServices.signUp(
        params.email,
        params.password!,
      );

      if (user != null) {
        final AuthParams saveParams = params;
        saveParams.id = user.uid;
        await _saveUserData(params: saveParams);
        showSuccessToast('Data Added Successfully');
        emit(AuthSuccessState());
      } else {
        showErrorToast('Something went wrong plz try again!');
        emit(AuthErrorState('Something went wrong plz try again!'));
      }
    } catch (e) {
      showErrorToast(e.toString());
      emit(AuthErrorState(e.toString()));
    }
  }

  /// Save User Data Method
  Future<void> _saveUserData({
    required final AuthParams params,
  }) async {
    try {
      emit(AuthLoadingState());
      await FirebaseServices.addData(
        collection: USER_COLLECTION,
        id: params.id,
        data: params.toJsonWithoutPassword(),
      );
    } catch (e) {
      showErrorToast(e.toString());
      emit(AuthErrorState(e.toString()));
    }
  }
}
