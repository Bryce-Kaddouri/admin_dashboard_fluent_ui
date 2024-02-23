import 'dart:typed_data';

import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';
import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../business/param/product_add_param.dart';

class ProductDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, ProductModel>> addProduct(
      ProductAddParam params) async {
    try {
      List<Map<String, dynamic>> response =
          await _client.from('products').insert(params.toJson()).select();
      print(response);
      if (response.isNotEmpty) {
        print('response is not empty');
        ProductModel productModel = ProductModel.fromJson(response[0]);
        print(productModel.toJson());
        return Right(productModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error adding product'));
      }
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: 'Error adding product'));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error adding product'));
    }
  }

  Future<Either<DatabaseFailure, List<ProductModel>>> getProducts() async {
    try {
      List<Map<String, dynamic>> response =
          await _client.from('products').select().order('id', ascending: true);
      if (response.isNotEmpty) {
        List<ProductModel> productList =
            response.map((e) => ProductModel.fromJson(e)).toList();
        return Right(productList);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting products'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error getting products'));
    }
  }

  Future<Either<DatabaseFailure, ProductModel>> getProductById(int id) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('products')
          .select()
          .eq('id', id)
          .limit(1)
          .order('id', ascending: true);
      if (response.isNotEmpty) {
        ProductModel productModel = ProductModel.fromJson(response[0]);
        return Right(productModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting product'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error getting product'));
    }
  }

  Stream<List<Map<String, dynamic>>> getProductByIdStream() {
    /*return _client
        .from('products')
        .stream(primaryKey: ['id']).order('id', ascending: true);*/
    try {
      return _client
          .from('products')
          .stream(primaryKey: ['id']).order('id', ascending: true);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Stream.empty();
    } catch (e) {
      print(e);
      return Stream.empty();
    }
  }

  Future<Either<DatabaseFailure, ProductModel>> updateProduct(
      ProductModel productModel) async {
    try {
      productModel = productModel.copyWith(updatedAt: DateTime.now());
      print('productModel from update datasource');
      print(productModel.toJson());
      Map<String, dynamic> productMap = productModel.toJson();
      productMap.removeWhere((key, value) => key == 'id');
      List<Map<String, dynamic>> response = await _client
          .from('products')
          .update(productMap)
          .eq('id', productModel.id)
          .select();
      print('response update');
      print(response);
      if (response.isNotEmpty) {
        ProductModel productModel = ProductModel.fromJson(response[0]);
        return Right(productModel);
      } else {
        print('response is empty');
        return Left(DatabaseFailure(errorMessage: 'Error updating product'));
      }
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: 'Error updating product'));
    } catch (e) {
      print('error updating product');
      return Left(DatabaseFailure(errorMessage: 'Error updating product'));
    }
  }

  Future<Either<StorageFailure, String>> uploadImage(Uint8List bytes) async {
    try {
      DateTime now = DateTime.now();
      final response = await _client.storage.from('products').uploadBinary(
            '$now.jpg',
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpg',
              upsert: true,
            ),
          );

      if (response != null) {
        return Right(response);
      } else {
        return Left(StorageFailure(errorMessage: 'Error uploading product'));
      }
    } on StorageException catch (error) {
      print('storage error');
      print(error);
      return Left(StorageFailure(errorMessage: 'Error uploading image'));
    } catch (e) {
      return Left(StorageFailure(errorMessage: 'Error uploading image'));
    }
  }

  Future<Either<StorageFailure, String>> getSignedUrl(String path) async {
    try {
      final response = await _client.storage.from('products').createSignedUrl(
            path,
            const Duration(days: 1).inSeconds,
          );
      if (response != null) {
        return Right(response);
      } else {
        return Left(StorageFailure(errorMessage: 'Error getting signed url'));
      }
    } on StorageException catch (error) {
      print('storage error');
      print(error);
      return Left(StorageFailure(errorMessage: 'Error getting signed url'));
    } catch (e) {
      return Left(StorageFailure(errorMessage: 'Error getting signed url'));
    }
  }

  // method to delete category
  Future<Either<DatabaseFailure, ProductModel>> deleteProduct(int id) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('products')
          .delete()
          .eq('id', id)
          .limit(1)
          .order('id', ascending: true)
          .select();
      if (response.isNotEmpty) {
        ProductModel productModel = ProductModel.fromJson(response[0]);
        return Right(productModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error deleting product'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error deleting product'));
    }
  }
}
