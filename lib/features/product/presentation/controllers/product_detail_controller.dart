import 'package:get/get.dart';

import 'package:getx_state_management/features/product/domain/models/product_model.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_recommendations_usecase.dart';

class ProductDetailController extends GetxController {
  ProductDetailController(
    this._getProductDetailUseCase,
    this._getRecommendationsUseCase,
  );

  final GetProductDetailUseCase _getProductDetailUseCase;
  final GetRecommendationsUseCase _getRecommendationsUseCase;

  final selectedProduct = Rxn<ProductModel>();
  final recommendations = <ProductModel>[].obs;
  final isLoadingDetail = false.obs;
  final isLoadingRecommendations = false.obs;
  final detailErrorMessage = RxnString();
  final recommendationErrorMessage = RxnString();

  Future<void> initialize(int? id) async {
    if (id == null) {
      detailErrorMessage.value = 'ID produk tidak valid.';
      return;
    }
    await loadProductDetail(id);
  }

  Future<void> loadProductDetail(int id) async {
    detailErrorMessage.value = null;
    recommendationErrorMessage.value = null;
    recommendations.clear();
    selectedProduct.value = null;
    isLoadingDetail.value = true;

    final detailResult = await _getProductDetailUseCase(id);
    if (detailResult.isSuccess) {
      selectedProduct.value = detailResult.data;
      await loadRecommendations(id);
    } else {
      detailErrorMessage.value =
          detailResult.failure?.message ?? 'Gagal memuat detail.';
    }

    isLoadingDetail.value = false;
  }

  Future<void> loadRecommendations(int id) async {
    isLoadingRecommendations.value = true;
    final result = await _getRecommendationsUseCase(id);
    if (result.isSuccess) {
      recommendations.assignAll(result.data ?? []);
    } else {
      recommendationErrorMessage.value =
          result.failure?.message ?? 'Gagal memuat rekomendasi.';
    }
    isLoadingRecommendations.value = false;
  }
}
