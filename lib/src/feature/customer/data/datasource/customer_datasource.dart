import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../business/param/customer_add_param.dart';
import '../model/customer_model.dart';

class CustomerDataSource {
  final _client = Supabase.instance.client;
  SupabaseClient _supaAdminClient = SupabaseClient(
      'https://qlhzemdpzbonyqdecfxn.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsaHplbWRwemJvbnlxZGVjZnhuIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwNDg4NjgwNiwiZXhwIjoyMDIwNDYyODA2fQ.iGkTZL6qeM5f6kXobuo2b6CUdHigONycJuofyjWtEpU');

  Future<Either<DatabaseFailure, bool>> addCustomer(
      CustomerAddParam params) async {
    try {
      Map<String, dynamic> response = await _client
          .from('customers')
          .insert(params.toJson())
          .select()
          .single();

      UserResponse res =
          await _supaAdminClient.auth.admin.createUser(AdminUserAttributes(
        phone: '+${params.countryCode}${params.phoneNumber}',
        userMetadata: {
          'fName': params.fName,
          'lName': params.lName,
          'id': response['id'],
        },
        appMetadata: {'role': 'CUSTOMER'},
        emailConfirm: true,
      ));
      print(res.user);

      print(response);

      return const Right(true);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
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
      customerMap['updated_at'] = DateTime.now().toIso8601String();
      Map<String, dynamic> response = await _client
          .from('customers')
          .update(customerMap)
          .eq('id', customerModel.id)
          .select()
          .single();
      print('response update');
      print(response);
      return Right(true);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print('error updating customer');
      print(e);
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
