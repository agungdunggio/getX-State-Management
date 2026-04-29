import 'package:getx_state_management/core/utils/result.dart';
import 'package:getx_state_management/features/auth/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<Result<UserModel>> login({
    required String username,
    required String password,
  });

  Future<void> logout();

  String? getSavedToken();
}
