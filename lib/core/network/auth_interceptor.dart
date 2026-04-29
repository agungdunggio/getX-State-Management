import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:getx_state_management/core/routes/app_routes.dart';
import 'package:getx_state_management/features/auth/presentation/controllers/auth_controller.dart';
import 'package:getx_state_management/core/constants/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);

  final GetStorage _storage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storage.read<String>(StorageKeys.authToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      if (Get.isRegistered<AuthController>()) {
        Get.find<AuthController>().logoutFromInterceptor();
      }
      if (Get.currentRoute != AppRoutes.login) {
        Get.offAllNamed(AppRoutes.login);
      }
    }
    super.onError(err, handler);
  }
}
