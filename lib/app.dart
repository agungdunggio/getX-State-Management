import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/di/dependency_injection.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/product/presentation/pages/product_detail_page.dart';
import 'features/product/presentation/pages/product_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Clean Architecture',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const products = '/products';
  static const productDetail = '/product-detail';
}

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: AppRoutes.splash, page: SplashPage.new),
    GetPage(name: AppRoutes.login, page: LoginPage.new),
    GetPage(name: AppRoutes.products, page: ProductListPage.new),
    GetPage(name: AppRoutes.productDetail, page: ProductDetailPage.new),
  ];
}
