import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:getx_state_management/features/auth/presentation/controllers/auth_controller.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(text: 'emilys');
  final passwordController = TextEditingController(text: 'emilyspass');

  final AuthController _authController = Get.find<AuthController>();

  RxBool get isLoading => _authController.isLoading;
  RxnString get errorMessage => _authController.errorMessage;

  Future<void> submitLogin() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    await _authController.login(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
