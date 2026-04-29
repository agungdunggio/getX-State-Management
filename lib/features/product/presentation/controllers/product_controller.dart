import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:getx_state_management/core/errors/failure.dart';
import 'package:getx_state_management/features/product/domain/models/product_model.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_products_usecase.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_recommendations_usecase.dart';

class ProductController extends GetxController {
  ProductController(
    this._getProductsUseCase,
    this._getProductDetailUseCase,
    this._getRecommendationsUseCase,
  );

  final GetProductsUseCase _getProductsUseCase;
  final GetProductDetailUseCase _getProductDetailUseCase;
  final GetRecommendationsUseCase _getRecommendationsUseCase;

  final products = <ProductModel>[].obs;
  final selectedProduct = Rxn<ProductModel>();
  final recommendations = <ProductModel>[].obs;

  final isLoadingProducts = false.obs;
  final isLoadingMore = false.obs;
  final isLoadingDetail = false.obs;
  final isLoadingRecommendations = false.obs;

  final productErrorMessage = RxnString();
  final detailErrorMessage = RxnString();
  final recommendationErrorMessage = RxnString();

  final scrollController = ScrollController();

  final _limit = 10;
  final _currentPage = 0.obs;
  final hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadInitialProducts() async {
    _currentPage.value = 0;
    hasMore.value = true;
    products.clear();
    await _fetchProducts(resetLoading: true);
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value || !hasMore.value || isLoadingProducts.value) {
      return;
    }
    await _fetchProducts();
  }

  Future<void> _fetchProducts({bool resetLoading = false}) async {
    productErrorMessage.value = null;
    if (resetLoading) {
      isLoadingProducts.value = true;
    } else {
      isLoadingMore.value = true;
    }

    final result = await _getProductsUseCase(
      limit: _limit,
      skip: _currentPage.value * _limit,
    );

    if (result.isSuccess) {
      final items = result.data ?? [];
      products.addAll(items);
      hasMore.value = items.length >= _limit;
      _currentPage.value++;
    } else {
      productErrorMessage.value = _mapFailure(result.failure);
    }

    isLoadingProducts.value = false;
    isLoadingMore.value = false;
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
      detailErrorMessage.value = _mapFailure(detailResult.failure);
    }

    isLoadingDetail.value = false;
  }

  Future<void> loadRecommendations(int id) async {
    isLoadingRecommendations.value = true;
    final result = await _getRecommendationsUseCase(id);
    if (result.isSuccess) {
      recommendations.assignAll(result.data ?? []);
    } else {
      recommendationErrorMessage.value = _mapFailure(result.failure);
    }
    isLoadingRecommendations.value = false;
  }

  void clearState() {
    products.clear();
    recommendations.clear();
    selectedProduct.value = null;
    productErrorMessage.value = null;
    detailErrorMessage.value = null;
    recommendationErrorMessage.value = null;
    isLoadingProducts.value = false;
    isLoadingMore.value = false;
    isLoadingDetail.value = false;
    isLoadingRecommendations.value = false;
    hasMore.value = true;
    _currentPage.value = 0;
  }

  void _onScroll() {
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 120) {
      loadMoreProducts();
    }
  }

  String _mapFailure(Failure? failure) {
    return failure?.message ?? 'Kesalahan tidak diketahui.';
  }
}
