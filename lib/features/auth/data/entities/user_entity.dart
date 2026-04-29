import 'package:getx_state_management/features/auth/domain/models/user_model.dart';

class UserEntity {
  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });

  final int id;
  final String username;
  final String email;
  final String token;

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      token: json['accessToken'] as String? ?? json['token'] as String? ?? '',
    );
  }

  UserModel toModel() {
    return UserModel(id: id, username: username, email: email, token: token);
  }
}
