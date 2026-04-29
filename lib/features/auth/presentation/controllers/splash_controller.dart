import 'package:get/get.dart';

import 'package:getx_state_management/features/auth/presentation/controllers/auth_controller.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Get.find<AuthController>().autoLogin();
  }
}
