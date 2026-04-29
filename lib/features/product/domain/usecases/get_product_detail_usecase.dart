import 'package:getx_state_management/core/utils/result.dart';
import 'package:getx_state_management/features/product/domain/models/product_model.dart';
import 'package:getx_state_management/features/product/domain/repositories/product_repository.dart';

class GetProductDetailUseCase {
  GetProductDetailUseCase(this._repository);

  final ProductRepository _repository;

  Future<Result<ProductModel>> call(int id) => _repository.getProductDetail(id);
}
