import 'package:getx_state_management/core/utils/result.dart';
import 'package:getx_state_management/features/auth/domain/models/user_model.dart';
import 'package:getx_state_management/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<UserModel>> call({
    required String username,
    required String password,
  }) {
    return _repository.login(username: username, password: password);
  }
}
