import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../business/param/customer_add_param.dart';
import '../model/customer_model.dart';

class CustomerDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, bool>> addCustomer(
      CustomerAddParam params) async {
    try {
      List<Map<String, dynamic>> response =
          await _client.from('categories').insert(params.toJson()).select();
      print(response);
      if (response.isNotEmpty) {
        print('response is not empty');
        CategoryModel categoryModel = CategoryModel.fromJson(response[0]);
        print(categoryModel.toJson());
        return const Right(true);
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

  Future<Either<DatabaseFailure, List<CustomerModel>>> getCustomers() async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .select()
          .order('id', ascending: true);
      if (response.isNotEmpty) {
        List<CustomerModel> customerList =
            response.map((e) => CustomerModel.fromJson(e)).toList();
        return Right(customerList);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting categories'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error getting categories'));
    }
  }

  Future<Either<DatabaseFailure, CustomerModel>> getCustomerById(int id) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .select()
          .eq('id', id)
          .limit(1)
          .order('id', ascending: true);
      if (response.isNotEmpty) {
        CustomerModel customerModel = CustomerModel.fromJson(response[0]);
        return Right(customerModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting category'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error getting category'));
    }
  }

  Stream<List<CategoryModel>> getCustomerByIdStream() {
    var res = _client
        .from('categories')
        .stream(primaryKey: ['id']).order('id', ascending: true);
    return res
        .map((event) => event.map((e) => CategoryModel.fromJson(e)).toList());
  }

  Future<Either<DatabaseFailure, bool>> updateCustomer(
      CustomerModel categoryModel) async {
    try {
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
        return Right(true);
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

  // method to delete category
  Future<Either<DatabaseFailure, bool>> deleteCustomer(int id) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .delete()
          .eq('id', id)
          .limit(1)
          .order('id', ascending: true)
          .select();
      if (response.isNotEmpty) {
        return const Right(true);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error deleting category'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error deleting category'));
    }
  }
}
