import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/customer_model.dart';
import '../repository/customer_repository.dart';

class CustomerGetCustomerByIdUseCase implements UseCase<CustomerModel, int> {
  final CustomerRepository customerRepository;

  const CustomerGetCustomerByIdUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<DatabaseFailure, CustomerModel>> call(int id) {
    return customerRepository.getCustomerById(id);
  }
}
