import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/business/repository/category_repository.dart';
import 'package:admin_dashboard/src/feature/product/business/repository/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/product_model.dart';
import '../param/product_add_param.dart';

class ProductAddUseCase implements UseCase<ProductModel, ProductAddParam> {
  final ProductRepository productRepository;

  const ProductAddUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<DatabaseFailure, ProductModel>> call(ProductAddParam params) {
    return productRepository.addProduct(params);
  }
}
