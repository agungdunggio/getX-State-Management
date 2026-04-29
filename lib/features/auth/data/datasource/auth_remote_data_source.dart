import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'package:getx_state_management/core/constants/storage_keys.dart';
import 'package:getx_state_management/core/errors/exceptions.dart';
import 'package:getx_state_management/core/network/api_endpoints.dart';
import 'package:getx_state_management/features/auth/data/entities/user_entity.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio, this._storage);

  final Dio _dio;
  final GetStorage _storage;

  Future<UserEntity> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {'username': username, 'password': password},
      );

      final data = response.data;
      if (data == null) {
        throw const ServerException('Respons login kosong.');
      }

      final model = UserEntity.fromJson(data);
      await _storage.write(StorageKeys.authToken, model.token);
      return model;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message']?.toString() ?? 'Gagal login.',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> clearSession() => _storage.remove(StorageKeys.authToken);

  String? getToken() => _storage.read<String>(StorageKeys.authToken);
}
