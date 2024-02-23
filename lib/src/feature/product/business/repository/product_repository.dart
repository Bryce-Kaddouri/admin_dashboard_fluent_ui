import 'dart:typed_data';

import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';
/*
import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
*/
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../param/product_add_param.dart';
/*
import '../../data/model/category_model.dart';
*/

abstract class ProductRepository {
  Future<Either<DatabaseFailure, ProductModel>> addProduct(
      ProductAddParam params);

  Future<Either<DatabaseFailure, List<ProductModel>>> getProducts(
      NoParams param);

  Future<Either<DatabaseFailure, ProductModel>> getProductById(int id);

  Future<Either<DatabaseFailure, ProductModel>> updateProduct(
      ProductModel category);

  Future<Either<StorageFailure, String>> uploadImage(Uint8List bytes);

  Future<Either<StorageFailure, String>> getSignedUrl(String path);

  Future<Either<DatabaseFailure, ProductModel>> deleteProduct(int id);
}
