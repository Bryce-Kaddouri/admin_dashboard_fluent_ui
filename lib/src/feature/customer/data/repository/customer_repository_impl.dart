import 'package:admin_dashboard/src/core/data/exception/failure.dart';
import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/param/customer_add_param.dart';
import 'package:admin_dashboard/src/feature/customer/data/model/customer_model.dart';
import 'package:dartz/dartz.dart';

import '../../business/repository/customer_repository.dart';
import '../datasource/customer_datasource.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerDataSource dataSource;

  CustomerRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DatabaseFailure, bool>> addCustomer(
      CustomerAddParam params) async {
    return await dataSource.addCustomer(params);
  }

  @override
  Future<Either<DatabaseFailure, bool>> deleteCustomer(int id) async {
    return await dataSource.deleteCustomer(id);
  }

  @override
  Future<Either<DatabaseFailure, CustomerModel>> getCustomerById(int id) async {
    return await dataSource.getCustomerById(id);
  }

  @override
  Future<Either<DatabaseFailure, List<CustomerModel>>> getCustomers(
      NoParams param) async {
    return await dataSource.getCustomers();
  }

  @override
  Future<Either<DatabaseFailure, bool>> updateCustomer(
      CustomerModel customer) async {
    return await dataSource.updateCustomer(customer);
  }

  /* @override
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
  }*/
}
