import 'package:get/get.dart';

import 'package:getx_state_management/core/routes/app_routes.dart';
import 'package:getx_state_management/features/auth/domain/models/user_model.dart';
import 'package:getx_state_management/features/auth/domain/usecases/get_saved_token_usecase.dart';
import 'package:getx_state_management/features/auth/domain/usecases/login_usecase.dart';
import 'package:getx_state_management/features/auth/domain/usecases/logout_usecase.dart';

class AuthController extends GetxController {
  AuthController(
    this._loginUseCase,
    this._logoutUseCase,
    this._getSavedTokenUseCase,
  );

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetSavedTokenUseCase _getSavedTokenUseCase;

  final isLoading = false.obs;
  final currentUser = Rxn<UserModel>();
  final errorMessage = RxnString();
  final isAuthenticated = false.obs;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    errorMessage.value = null;
    isLoading.value = true;

    final result = await _loginUseCase(username: username, password: password);
    if (result.isSuccess) {
      currentUser.value = result.data;
      isAuthenticated.value = true;
      // Product list akan load sendiri lewat ProductListController.onReady
      Get.offAllNamed(AppRoutes.products);
    } else {
      errorMessage.value = result.failure?.message ?? 'Gagal login.';
    }

    isLoading.value = false;
  }

  Future<void> logout() async {
    isLoading.value = true;
    await _logoutUseCase();
    _clearState();
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> autoLogin() async {
    final token = _getSavedTokenUseCase();
    if (token is String && token.isNotEmpty) {
      isAuthenticated.value = true;
      Get.offAllNamed(AppRoutes.products);
      return;
    }
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> logoutFromInterceptor() async {
    await _logoutUseCase();
    _clearState();
  }

  void _clearState() {
    currentUser.value = null;
    errorMessage.value = null;
    isAuthenticated.value = false;
  }
}
