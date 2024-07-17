part of 'teams_cubit.dart';

abstract class TeamsState {}

final class InitialState extends TeamsState {}

final class LoadingState extends TeamsState {}

final class SuccessState extends TeamsState {}

final class ErrorState extends TeamsState {}
