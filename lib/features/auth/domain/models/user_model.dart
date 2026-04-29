class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });

  final int id;
  final String username;
  final String email;
  final String token;
}
