class TeamModel {
  final DateTime dateTime;
  final String id;
  final String name;
  final int subTeamCount;

  TeamModel({
    required this.dateTime,
    required this.id,
    required this.name,
    required this.subTeamCount,
  });

  factory TeamModel.formMap(Map<String, dynamic> data) => TeamModel(
        dateTime: data['date_time'].toDate(),
        id: data['id'],
        name: data['name'],
        subTeamCount: data['sub_team_count'],
      );
}
