import 'package:get/get.dart';

import 'package:getx_state_management/core/routes/app_routes.dart';
import 'package:getx_state_management/features/auth/presentation/bindings/auth_binding.dart';
import 'package:getx_state_management/features/auth/presentation/bindings/login_binding.dart';
import 'package:getx_state_management/features/auth/presentation/bindings/splash_binding.dart';
import 'package:getx_state_management/features/auth/presentation/pages/login_page.dart';
import 'package:getx_state_management/features/auth/presentation/pages/splash_page.dart';
import 'package:getx_state_management/features/product/presentation/bindings/product_detail_binding.dart';
import 'package:getx_state_management/features/product/presentation/bindings/product_list_binding.dart';
import 'package:getx_state_management/features/product/presentation/pages/product_detail_page.dart';
import 'package:getx_state_management/features/product/presentation/pages/product_list_page.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: SplashPage.new,
      bindings: [AuthBinding(), SplashBinding()],
    ),
    GetPage(
      name: AppRoutes.login,
      page: LoginPage.new,
      bindings: [AuthBinding(), LoginBinding()],
    ),
    GetPage(
      name: AppRoutes.products,
      page: ProductListPage.new,
      bindings: [AuthBinding(), ProductListBinding()],
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: ProductDetailPage.new,
      binding: ProductDetailBinding(),
    ),
  ];
}
