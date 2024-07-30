class AttendanceModel {
  final String id;
  final String teamId;
  final String subTeamId;
  final String memberId;
  final DateTime dateTime;

  const AttendanceModel({
    required this.id,
    required this.memberId,
    required this.teamId,
    required this.subTeamId,
    required this.dateTime,
  });

  factory AttendanceModel.formMap(Map<String, dynamic> data) => AttendanceModel(
        id: data['id'],
        memberId: data['user_id'],
        subTeamId: data['sub_team_id'],
        teamId: data['team_id'],
        dateTime: data['date_time'].toDate(),
      );
}
