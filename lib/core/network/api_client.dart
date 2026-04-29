import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'api_endpoints.dart';
import 'auth_interceptor.dart';

class ApiClient {
  ApiClient(GetStorage storage)
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
        ),
      ) {
    dio.interceptors.add(AuthInterceptor(storage));
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: false),
    );
  }

  final Dio dio;
}
