import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/business/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/product_model.dart';
import '../repository/product_repository.dart';

class ProductGetProductsUseCase
    implements UseCase<List<ProductModel>, NoParams> {
  final ProductRepository productRepository;

  const ProductGetProductsUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<DatabaseFailure, List<ProductModel>>> call(NoParams params) {
    return productRepository.getProducts(params);
  }
}
