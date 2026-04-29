import 'package:dio/dio.dart';

import 'package:getx_state_management/core/errors/exceptions.dart';
import 'package:getx_state_management/core/errors/failure.dart';
import 'package:getx_state_management/core/utils/result.dart';
import 'package:getx_state_management/features/product/domain/models/product_model.dart';
import 'package:getx_state_management/features/product/domain/repositories/product_repository.dart';
import 'package:getx_state_management/features/product/data/datasource/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<Result<ProductModel>> getProductDetail(int id) async {
    try {
      final model = await _remoteDataSource.getProductDetail(id);
      return Result.success(model.toModel());
    } on NetworkException catch (e) {
      return Result.error(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.error(ServerFailure(e.message));
    } on DioException catch (e) {
      return Result.error(NetworkFailure(e.message ?? 'Tidak ada koneksi.'));
    } catch (_) {
      return Result.error(
        const UnknownFailure('Terjadi kesalahan tidak terduga.'),
      );
    }
  }

  @override
  Future<Result<List<ProductModel>>> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final models = await _remoteDataSource.getProducts(
        limit: limit,
        skip: skip,
      );
      return Result.success(models.map((e) => e.toModel()).toList());
    } on NetworkException catch (e) {
      return Result.error(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.error(ServerFailure(e.message));
    } on DioException catch (e) {
      return Result.error(NetworkFailure(e.message ?? 'Tidak ada koneksi.'));
    } catch (_) {
      return Result.error(
        const UnknownFailure('Terjadi kesalahan tidak terduga.'),
      );
    }
  }

  @override
  Future<Result<List<ProductModel>>> getRecommendations(int id) async {
    try {
      final models = await _remoteDataSource.getRecommendations(id);
      return Result.success(models.map((e) => e.toModel()).toList());
    } on NetworkException catch (e) {
      return Result.error(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.error(ServerFailure(e.message));
    } on DioException catch (e) {
      return Result.error(NetworkFailure(e.message ?? 'Tidak ada koneksi.'));
    } catch (_) {
      return Result.error(
        const UnknownFailure('Terjadi kesalahan tidak terduga.'),
      );
    }
  }
}
