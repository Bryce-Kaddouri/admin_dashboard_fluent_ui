import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/product_model.dart';
import '../param/update_product_param.dart';
import '../repository/product_repository.dart';

class ProductUpdateUseCase implements UseCase<ProductModel, UpdateProductParam> {
  final ProductRepository productRepository;

  const ProductUpdateUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<DatabaseFailure, ProductModel>> call(UpdateProductParam param) {
    return productRepository.updateProduct(param);
  }
}
