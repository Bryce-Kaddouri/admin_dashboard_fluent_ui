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
          await _client.from('customers').insert(params.toJson()).select();
      print(response);
      if (response.isNotEmpty) {
        print('response is not empty');
        return const Right(true);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error adding customer'));
      }
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: 'Error adding customer'));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error adding customer'));
    }
  }

  Future<Either<DatabaseFailure, List<CustomerModel>>> getCustomers() async {
    try {
      List<Map<String, dynamic>> response =
          await _client.from('customers').select().order('id', ascending: true);
      if (response.isNotEmpty) {
        print('response is not empty customers');
        print(response);
        List<CustomerModel> customerList =
            response.map((e) => CustomerModel.fromJson(e)).toList();
        print(customerList);
        return Right(customerList);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting categories'));
      }
    } catch (e) {
      print('error getting categories');
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting categories'));
    }
  }

  Future<Either<DatabaseFailure, CustomerModel>> getCustomerById(int id) async {
    print('get customer by id');
    print(id.runtimeType);
    try {
      Map<String, dynamic> response = await _client
          .from('customers')
          .select()
          .eq('id', id)
          .single()
          .order('id', ascending: true);
      print('response get customer by id');
      if (response != null) {
        CustomerModel customerModel = CustomerModel.fromJson(response);
        print('customerModel');
        return Right(customerModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting category'));
      }
    } catch (e) {
      print('error getting customer');
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting category'));
    }
  }

  Future<Either<DatabaseFailure, bool>> updateCustomer(
      CustomerModel customerModel) async {
    try {
      print('categoryModel from update datasource');
      print(customerModel.toJson());
      Map<String, dynamic> customerMap = customerModel.toJson();
      List<Map<String, dynamic>> response = await _client
          .from('customers')
          .update(customerMap)
          .eq('id', customerModel.id)
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
          .from('customers')
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
