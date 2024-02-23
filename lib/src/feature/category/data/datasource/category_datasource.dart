import 'dart:typed_data';

import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';

class CategoryDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, CategoryModel>> addCategory(
      CategoryAddParam params) async {
    try {
      List<Map<String, dynamic>> response =
          await _client.from('categories').insert(params.toJson()).select();
      print(response);
      if (response.isNotEmpty) {
        print('response is not empty');
        CategoryModel categoryModel = CategoryModel.fromJson(response[0]);
        print(categoryModel.toJson());
        return Right(categoryModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error adding category'));
      }
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: 'Error adding category'));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error adding category'));
    }
  }

  Future<Either<DatabaseFailure, List<CategoryModel>>> getCategories() async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .select()
          .order('id', ascending: true);
      if (response.isNotEmpty) {
        List<CategoryModel> categoryList =
            response.map((e) => CategoryModel.fromJson(e)).toList();
        return Right(categoryList);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting categories'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error getting categories'));
    }
  }

  Future<Either<DatabaseFailure, CategoryModel>> getCategoryById(int id) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .select()
          .eq('id', id)
          .limit(1)
          .order('id', ascending: true);
      if (response.isNotEmpty) {
        CategoryModel categoryModel = CategoryModel.fromJson(response[0]);
        return Right(categoryModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting category'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error getting category'));
    }
  }

  Stream<List<CategoryModel>> getCategoryByIdStream() {
    var res =  _client
        .from('categories')
        .stream(primaryKey: ['id']).order('id', ascending: true);
    return res.map((event) => event.map((e) => CategoryModel.fromJson(e)).toList());
  }

  Future<Either<DatabaseFailure, CategoryModel>> updateCategory(
      CategoryModel categoryModel) async {
    try {
      categoryModel = categoryModel.copyWith(updatedAt: DateTime.now());
      print('categoryModel from update datasource');
      print(categoryModel.toJson());
      Map<String, dynamic> categoryMap = categoryModel.toJson();
      categoryMap.removeWhere((key, value) => key == 'id');
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .update(categoryMap)
          .eq('id', categoryModel.id)
          .select();
      print('response update');
      print(response);
      if (response.isNotEmpty) {
        CategoryModel categoryModel = CategoryModel.fromJson(response[0]);
        return Right(categoryModel);
      } else {
        print('response is empty');
        return Left(DatabaseFailure(errorMessage: 'Error updating category'));
      }
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: 'Error updating category'));
    } catch (e) {
      print('error updating category');
      return Left(DatabaseFailure(errorMessage: 'Error updating category'));
    }
  }

  Future<Either<StorageFailure, String>> uploadImage(Uint8List bytes) async {
    try {
      DateTime now = DateTime.now();
      int milliseconds = now.millisecondsSinceEpoch;
      final response =  await _client.storage.from('categories').uploadBinary(
            '$milliseconds.jpg',
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpg',
              upsert: true,
            ),
          );
      String path= response.split('categories/')[1];
      print('response from upload image');
      print(response);
      String? url = await _client.storage.from('categories').createSignedUrl(
        path,
        const Duration(days: 365).inSeconds,
      );

      print('url from upload image');
      print(url);

      if (url != null) {
        return Right(url!);
      } else {
        return Left(StorageFailure(errorMessage: 'Error uploading image'));
      }
    } on StorageException catch (error) {
      print('storage error');
      print(error);
      return Left(StorageFailure(errorMessage: 'Error uploading image'));
    } catch (e) {
      return Left(StorageFailure(errorMessage: 'Error uploading image'));
    }
  }

  Future<String?> getSignedUrlAsync(String path) async {
    try {
      final response = await _client.storage.from('categories').createSignedUrl(
        path,
        const Duration(days: 3650).inSeconds,
      );
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } on StorageException catch (error) {
      print('storage error');
      print(error);
      return null;
    } catch (e) {
      return null ;
    }
  }

  Future<Either<StorageFailure, String>> getSignedUrl(String path) async {
    try {
      final response = await _client.storage.from('categories').createSignedUrl(
            path,
            const Duration(days: 3650).inSeconds,
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
  Future<Either<DatabaseFailure, CategoryModel>> deleteCategory(int id) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .delete()
          .eq('id', id)
          .limit(1)
          .order('id', ascending: true)
          .select();
      if (response.isNotEmpty) {
        CategoryModel categoryModel = CategoryModel.fromJson(response[0]);
        return Right(categoryModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error deleting category'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error deleting category'));
    }
  }
}
