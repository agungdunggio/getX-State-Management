import 'package:dio/dio.dart';

import 'package:getx_state_management/core/errors/exceptions.dart';
import 'package:getx_state_management/core/errors/failure.dart';
import 'package:getx_state_management/core/utils/result.dart';
import 'package:getx_state_management/features/auth/domain/models/user_model.dart';
import 'package:getx_state_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:getx_state_management/features/auth/data/datasource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Result<UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final model = await _remoteDataSource.login(
        username: username,
        password: password,
      );
      return Result.success(model.toModel());
    } on NetworkException catch (e) {
      return Result.error(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.error(ServerFailure(e.message));
    } on DioException catch (e) {
      return Result.error(NetworkFailure(e.message ?? 'Tidak ada koneksi.'));
    } catch (_) {
      return Result.error(
        const UnknownFailure('Terjadi kesalahan tidak terduga.'),
      );
    }
  }

  @override
  String? getSavedToken() => _remoteDataSource.getToken();

  @override
  Future<void> logout() => _remoteDataSource.clearSession();
}
