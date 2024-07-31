part of 'profile_cubit.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {}

final class ProfileError extends ProfileState {}

final class ProfileEditUpdate extends ProfileState {}
