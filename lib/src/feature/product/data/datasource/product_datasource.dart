import 'dart:typed_data';

import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../business/param/product_add_param.dart';
import '../../business/param/update_product_param.dart';

class ProductDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, ProductModel>> addProduct(ProductAddParam params) async {
    try {
      List<Map<String, dynamic>> response = await _client.from('products').insert(params.toJson()).select();
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
      List<Map<String, dynamic>> response = await _client.from('products').select().order('id', ascending: true);

      print('response getProducts');

      List<ProductModel> productList = [];
      for (Map<String, dynamic> json in response) {
        print('json');
        ProductModel product = ProductModel.fromJson(json);
        productList.add(product);
      }
      print('productList');
      print(productList.length);
      return Right(productList);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting products'));
    }
  }

  Future<Either<DatabaseFailure, ProductModel>> getProductById(int id) async {
    try {
      List<Map<String, dynamic>> response = await _client.from('products').select().eq('id', id).limit(1).order('id', ascending: true);
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

  Stream<List<ProductModel>> getProductByIdStream() {
    /*return _client
        .from('products')
        .stream(primaryKey: ['id']).order('id', ascending: true);*/
    try {
      return _client.from('products').stream(primaryKey: ['id']).order('id', ascending: true).map((event) {
            List<ProductModel> productList = event.map((e) => ProductModel.fromJson(e)).toList();
            return productList;
          });
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Stream.empty();
    } catch (e) {
      print(e);
      return Stream.empty();
    }
  }

  Future<Either<DatabaseFailure, ProductModel>> updateProduct(UpdateProductParam param) async {
    try {
      ProductModel productModel = param.productModel.copyWith(updatedAt: DateTime.now());
      print('productModel from update datasource');
      print(productModel.toJson());
      print(param.savePriceHistory);
      if (param.savePriceHistory) {
        print('save price history');
        await _client.rpc('save_previous_price', params: {'product_id_param': productModel.id});
        print('resPrice');
      }
      Map<String, dynamic> productMap = productModel.toJson();
      productMap.removeWhere((key, value) => key == 'id');
      List<Map<String, dynamic>> response = await _client.from('products').update(productMap).eq('id', productModel.id).select();
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
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error updating product'));
    }
  }

  Future<Either<StorageFailure, String>> uploadImage(Uint8List bytes) async {
    try {
      DateTime now = DateTime.now();
      int milliseconds = now.millisecondsSinceEpoch;
      String? url;
      final response = await _client.storage.from('products').uploadBinary(
            '$milliseconds.jpg',
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpg',
              upsert: true,
            ),
          );
      String path = response.split('products/')[1];
      url = await _client.storage.from('products').createSignedUrl(
            path,
            const Duration(days: 365).inSeconds,
          );

      if (url != null) {
        return Right(url!);
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
      print('delete product');
      print(id);
      Map<String, dynamic> response = await _client.from('products').delete().eq('id', id).order('id', ascending: true).select().single();

      print('response delete');
      print(response);
      ProductModel productModel = ProductModel.fromJson(response);
      return Right(productModel);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error.message);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error deleting product'));
    }
  }
}
