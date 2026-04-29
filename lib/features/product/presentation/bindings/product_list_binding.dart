import 'package:get/get.dart';

import 'package:getx_state_management/features/product/domain/usecases/get_products_usecase.dart';
import 'package:getx_state_management/features/product/presentation/controllers/product_list_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListController>(
      () => ProductListController(Get.find<GetProductsUseCase>()),
      fenix: true,
    );
  }
}
