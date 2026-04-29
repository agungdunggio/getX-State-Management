import 'package:getx_state_management/core/utils/result.dart';
import 'package:getx_state_management/features/product/domain/models/product_model.dart';

abstract class ProductRepository {
  Future<Result<List<ProductModel>>> getProducts({
    required int limit,
    required int skip,
  });

  Future<Result<ProductModel>> getProductDetail(int id);

  Future<Result<List<ProductModel>>> getRecommendations(int id);
}
