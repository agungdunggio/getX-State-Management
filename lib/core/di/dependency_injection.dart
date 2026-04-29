import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:getx_state_management/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:getx_state_management/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:getx_state_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:getx_state_management/features/auth/domain/usecases/get_saved_token_usecase.dart';
import 'package:getx_state_management/features/auth/domain/usecases/login_usecase.dart';
import 'package:getx_state_management/features/auth/domain/usecases/logout_usecase.dart';
import 'package:getx_state_management/features/product/data/datasource/product_remote_data_source.dart';
import 'package:getx_state_management/features/product/data/repositories/product_repository_impl.dart';
import 'package:getx_state_management/features/product/domain/repositories/product_repository.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_products_usecase.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_recommendations_usecase.dart';
import 'package:getx_state_management/core/network/api_client.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GetStorage>(GetStorage(), permanent: true);

    Get.lazyPut<ApiClient>(
      () => ApiClient(Get.find<GetStorage>()),
      fenix: true,
    );

    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        Get.find<ApiClient>().dio,
        Get.find<GetStorage>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(Get.find<ApiClient>().dio),
      fenix: true,
    );

    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(Get.find<ProductRemoteDataSource>()),
      fenix: true,
    );

    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => LogoutUseCase(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(
      () => GetSavedTokenUseCase(Get.find<AuthRepository>()),
      fenix: true,
    );

    Get.lazyPut(
      () => GetProductsUseCase(Get.find<ProductRepository>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetProductDetailUseCase(Get.find<ProductRepository>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetRecommendationsUseCase(Get.find<ProductRepository>()),
      fenix: true,
    );
  }
}
