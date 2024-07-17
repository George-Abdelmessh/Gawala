class TeamMemberParams {
  final String id;
  final String name;
  final String phone;
  final String position;
  final int age;
  final String team;
  final String subTeam;
  final DateTime dateTime;

  const TeamMemberParams({
    required this.id,
    required this.name,
    required this.phone,
    required this.position,
    required this.age,
    required this.team,
    required this.subTeam,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'position': position,
        'age': age,
        'team': team,
        'sub_team': subTeam,
        'date_time': dateTime,
      };
}
