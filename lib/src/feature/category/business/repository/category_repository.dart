import 'dart:typed_data';

import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../data/model/category_model.dart';

abstract class CategoryRepository {
  Future<Either<DatabaseFailure, CategoryModel>> addCategory(
      CategoryAddParam params);

  Future<Either<DatabaseFailure, List<CategoryModel>>> getCategories(
      NoParams param);

  Future<Either<DatabaseFailure, CategoryModel>> getCategoryById(int id);

  Future<Either<DatabaseFailure, CategoryModel>> updateCategory(
      CategoryModel category);

  Future<Either<StorageFailure, String>> uploadImage(Uint8List bytes);
  Future<Either<StorageFailure, String>> getSignedUrl(String path);
  Future<Either<DatabaseFailure, CategoryModel>> deleteCategory(int id);
}
