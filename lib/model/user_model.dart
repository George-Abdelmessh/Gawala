class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime createAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createAt,
  });

  factory UserModel.formMap(Map<String, dynamic> data) => UserModel(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        createAt: data['created_at'].toDate(),
      );
}
