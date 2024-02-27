import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../data/model/customer_model.dart';
import '../param/customer_add_param.dart';

abstract class CustomerRepository {
  Future<Either<DatabaseFailure, bool>> addCustomer(CustomerAddParam params);

  Future<Either<DatabaseFailure, List<CustomerModel>>> getCustomers(
      NoParams param);

  Future<Either<DatabaseFailure, CustomerModel>> getCustomerById(int id);

  Future<Either<DatabaseFailure, bool>> updateCustomer(CustomerModel customer);
  Future<Either<DatabaseFailure, bool>> deleteCustomer(int id);
}
