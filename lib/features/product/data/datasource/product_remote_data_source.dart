import 'package:dio/dio.dart';

import 'package:getx_state_management/core/errors/exceptions.dart';
import 'package:getx_state_management/core/network/api_endpoints.dart';
import 'package:getx_state_management/features/product/data/entities/product_entity.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductEntity>> getProducts({
    required int limit,
    required int skip,
  });

  Future<ProductEntity> getProductDetail(int id);

  Future<List<ProductEntity>> getRecommendations(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<ProductEntity>> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.products,
        queryParameters: {'limit': limit, 'skip': skip},
      );
      final products = (response.data?['products'] as List<dynamic>? ?? [])
          .map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
          .toList();
      return products;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message']?.toString() ?? 'Gagal mengambil produk.',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ProductEntity> getProductDetail(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.products}/$id',
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException('Detail produk kosong.');
      }
      return ProductEntity.fromJson(data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message']?.toString() ??
            'Gagal mengambil detail produk.',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<List<ProductEntity>> getRecommendations(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.products}/$id',
      );
      final category = response.data?['category'] as String?;
      if (category == null || category.isEmpty) {
        return [];
      }

      final recommendationResponse = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.products}/category/$category',
        queryParameters: {'limit': 10},
      );
      final products =
          (recommendationResponse.data?['products'] as List<dynamic>? ?? [])
              .where((e) => (e as Map<String, dynamic>)['id'] != id)
              .map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
              .toList();
      return products;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message']?.toString() ??
            'Gagal mengambil rekomendasi.',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
