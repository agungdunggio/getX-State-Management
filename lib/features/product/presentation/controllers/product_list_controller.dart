import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:getx_state_management/core/errors/failure.dart';
import 'package:getx_state_management/features/product/domain/models/product_model.dart';
import 'package:getx_state_management/features/product/domain/usecases/get_products_usecase.dart';

class ProductListController extends GetxController {
  ProductListController(this._getProductsUseCase);

  final GetProductsUseCase _getProductsUseCase;

  final products = <ProductModel>[].obs;
  final isLoadingProducts = false.obs;
  final isLoadingMore = false.obs;
  final productErrorMessage = RxnString();
  final hasMore = true.obs;
  final scrollController = ScrollController();

  final _limit = 10;
  final _currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  @override
  void onReady() {
    super.onReady();
    if (products.isEmpty) {
      loadInitialProducts();
    }
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

  void clearState() {
    products.clear();
    productErrorMessage.value = null;
    isLoadingProducts.value = false;
    isLoadingMore.value = false;
    hasMore.value = true;
    _currentPage.value = 0;
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

  void _onScroll() {
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 120) {
      loadMoreProducts();
    }
  }

  String _mapFailure(Failure? failure) =>
      failure?.message ?? 'Kesalahan tidak diketahui.';
}
