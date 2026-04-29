import 'package:getx_state_management/core/utils/result.dart';
import 'package:getx_state_management/features/product/domain/models/product_model.dart';
import 'package:getx_state_management/features/product/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  GetProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Result<List<ProductModel>>> call({
    required int limit,
    required int skip,
  }) {
    return _repository.getProducts(limit: limit, skip: skip);
  }
}
