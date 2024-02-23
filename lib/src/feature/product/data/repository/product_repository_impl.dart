import 'dart:typed_data';

import 'package:admin_dashboard/src/core/data/exception/failure.dart';
import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';

import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';

import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';
import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';

import 'package:dartz/dartz.dart';

import '../../business/param/product_add_param.dart';
import '../../business/repository/product_repository.dart';
import '../datasource/product_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DatabaseFailure, ProductModel>> addProduct(
      ProductAddParam params) async {
    return await dataSource.addProduct(params);
  }

  @override
  Future<Either<DatabaseFailure, List<ProductModel>>> getProducts(
      NoParams param) async {
    return await dataSource.getProducts();
  }

  @override
  Future<Either<DatabaseFailure, ProductModel>> getProductById(int id) async {
    return await dataSource.getProductById(id);
  }

  @override
  Future<Either<DatabaseFailure, ProductModel>> updateProduct(
      ProductModel product) async {
    return await dataSource.updateProduct(product);
  }

  @override
  Future<Either<StorageFailure, String>> uploadImage(Uint8List bytes) async {
    return await dataSource.uploadImage(bytes);
  }

  @override
  Future<Either<StorageFailure, String>> getSignedUrl(String path) async {
    return await dataSource.getSignedUrl(path);
  }

  @override
  Future<Either<DatabaseFailure, ProductModel>> deleteProduct(int id) async {
    return await dataSource.deleteProduct(id);
  }
}
