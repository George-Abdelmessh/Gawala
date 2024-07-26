part of 'attendance_cubit.dart';

abstract class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceError extends AttendanceState {}

final class AttendanceSuccess extends AttendanceState {}
