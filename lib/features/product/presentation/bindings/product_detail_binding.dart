import 'package:get/get.dart';

import 'package:getx_state_management/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_recommendations_usecase.dart';
import 'package:getx_state_management/features/product/presentation/controllers/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(
        Get.find<GetProductDetailUseCase>(),
        Get.find<GetRecommendationsUseCase>(),
      ),
    );
  }
}
