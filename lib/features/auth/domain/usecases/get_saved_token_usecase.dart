import 'package:getx_state_management/features/auth/domain/repositories/auth_repository.dart';

class GetSavedTokenUseCase {
  GetSavedTokenUseCase(this._repository);

  final AuthRepository _repository;

  String? call() => _repository.getSavedToken();
}
