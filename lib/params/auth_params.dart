class AuthParams {
  String? id;
  String? name;
  final String email;
  final String? password;

  AuthParams({
    this.id,
    this.name,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
      };

  Map<String, dynamic> toJsonWithoutPassword() => {
        "id": id,
        "name": name,
        "email": email,
        "created_at": DateTime.now(),
      };
}
