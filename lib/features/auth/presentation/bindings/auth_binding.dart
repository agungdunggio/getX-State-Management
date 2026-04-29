import 'package:get/get.dart';

import 'package:getx_state_management/features/auth/presentation/controllers/auth_controller.dart';
import 'package:getx_state_management/features/auth/domain/usecases/get_saved_token_usecase.dart';
import 'package:getx_state_management/features/auth/domain/usecases/login_usecase.dart';
import 'package:getx_state_management/features/auth/domain/usecases/logout_usecase.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        Get.find<LoginUseCase>(),
        Get.find<LogoutUseCase>(),
        Get.find<GetSavedTokenUseCase>(),
      ),
      fenix: true,
    );
  }
}
