/*
import 'dart:typed_data';

import 'package:admin_dashboard/src/core/data/exception/failure.dart';
import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';

import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';

import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';
import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';

import 'package:dartz/dartz.dart';

import '../../business/param/user_add_param.dart';
import '../../business/repository/user_repository.dart';
import '../datasource/user_datasource.dart';
*/

import 'package:admin_dashboard/src/core/data/exception/failure.dart';

import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';

import 'package:admin_dashboard/src/feature/user/business/param/user_add_param.dart';
import 'package:admin_dashboard/src/feature/user/business/param/user_update_param.dart';

import 'package:dartz/dartz.dart';

import 'package:gotrue/src/types/user.dart';

import '../../business/repository/user_repository.dart';
import '../datasource/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DatabaseFailure, User>> addUser(UserAddParam params) async {
    return await dataSource.addUser(params);
  }

  @override
  Future<Either<DatabaseFailure, bool>> deleteUser(String uid) async {
    return await dataSource.deleteUser(uid);
  }

  @override
  Future<Either<DatabaseFailure, User>> getUserById(String uid) async {
    return await dataSource.getUserById(uid);
  }

  @override
  Future<Either<DatabaseFailure, List<User>>> getUsers(NoParams param) async {
    return await dataSource.getUsers();
  }

  @override
  Future<Either<DatabaseFailure, User>> updateUser(UserUpdateParam user) async {
    return await dataSource.updateUser(user);
  }

/* @override
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
  }*/
}
