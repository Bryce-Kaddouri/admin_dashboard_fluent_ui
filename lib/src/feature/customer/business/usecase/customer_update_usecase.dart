import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/customer_model.dart';
import '../repository/customer_repository.dart';

class CustomerUpdateUseCase implements UseCase<bool, CustomerModel> {
  final CustomerRepository customerRepository;

  const CustomerUpdateUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<DatabaseFailure, bool>> call(CustomerModel customerModel) {
    return customerRepository.updateCustomer(customerModel);
  }
}
