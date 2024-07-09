part of 'auth_cubit.dart';

abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String errorMessage;

  AuthErrorState(this.errorMessage);
}
