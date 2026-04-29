import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_state_management/features/auth/presentation/controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller;
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
