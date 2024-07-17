class TeamModel {
  final DateTime dateTime;
  final String id;
  final String name;
  final int subTeamCount;
  final int teamMembersCount;

  TeamModel({
    required this.dateTime,
    required this.id,
    required this.name,
    required this.subTeamCount,
    required this.teamMembersCount,
  });

  factory TeamModel.formMap(Map<String, dynamic> data) => TeamModel(
        dateTime: data['date_time'].toDate(),
        id: data['id'],
        name: data['name'],
        subTeamCount: data['sub_team_count'],
        teamMembersCount: data['team_members_count'],
      );
}
