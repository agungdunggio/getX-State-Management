import 'package:get/get.dart';

import 'package:getx_state_management/features/auth/presentation/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(LoginController.new);
  }
}
