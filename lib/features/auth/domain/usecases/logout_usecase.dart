import 'package:getx_state_management/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
