import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/customer_model.dart';
import '../repository/customer_repository.dart';

class CustomerGetCustomersUseCase
    implements UseCase<List<CustomerModel>, NoParams> {
  final CustomerRepository customerRepository;

  const CustomerGetCustomersUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<DatabaseFailure, List<CustomerModel>>> call(NoParams params) {
    return customerRepository.getCustomers(params);
  }
}
