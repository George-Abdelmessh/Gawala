class TeamParams {
  final String? id;
  final String name;
  final DateTime dateTime;
  final int? subTeamCount;
  final int? teamMembersCount;

  const TeamParams({
    this.id,
    required this.name,
    required this.dateTime,
    this.subTeamCount,
    this.teamMembersCount,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": name,
      "date_time": DateTime.now(),
    };

    if (id != null) {
      data['id'] = id;
    }

    if (subTeamCount != null) {
      data['sub_team_count'] = subTeamCount;
    }

    if (teamMembersCount != null) {
      data['team_members_count'] = teamMembersCount;
    }

    return data;
  }
}

