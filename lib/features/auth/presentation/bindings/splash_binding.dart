import 'package:get/get.dart';

import 'package:getx_state_management/features/auth/presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
