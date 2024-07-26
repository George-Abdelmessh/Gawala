class TeamMemberModel {
  final String id;
  final String name;
  final String position;
  final String phone;
  final int age;
  final String teamId;
  final String subTeamId;
  final DateTime dateTime;

  const TeamMemberModel({
    required this.dateTime,
    required this.id,
    required this.name,
    required this.phone,
    required this.position,
    required this.age,
    required this.teamId,
    required this.subTeamId,
  });

  factory TeamMemberModel.formMap(Map<String, dynamic> data) => TeamMemberModel(
        dateTime: data['date_time'].toDate(),
        id: data['id'],
        name: data['name'],
        position: data['position'],
        phone: data['phone'],
        age: data['age'],
        subTeamId: data['sub_team'],
        teamId: data['team'],
      );
}
