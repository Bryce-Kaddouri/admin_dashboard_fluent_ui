import 'dart:typed_data';

import 'package:admin_dashboard/src/core/data/exception/failure.dart';
import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';

import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';

import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';

import 'package:dartz/dartz.dart';

import '../../business/repository/category_repository.dart';
import '../datasource/category_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DatabaseFailure, CategoryModel>> addCategory(
      CategoryAddParam params) async {
    return await dataSource.addCategory(params);
  }

  @override
  Future<Either<DatabaseFailure, List<CategoryModel>>> getCategories(
      NoParams param) async {
    return await dataSource.getCategories();
  }

  @override
  Future<Either<DatabaseFailure, CategoryModel>> getCategoryById(int id) async {
    return await dataSource.getCategoryById(id);
  }

  @override
  Future<Either<DatabaseFailure, CategoryModel>> updateCategory(
      CategoryModel category) async {
    return await dataSource.updateCategory(category);
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
  Future<Either<DatabaseFailure, CategoryModel>> deleteCategory(int id) async {
    return await dataSource.deleteCategory(id);
  }
}
