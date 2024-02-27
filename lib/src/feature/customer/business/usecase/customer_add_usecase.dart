import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../param/customer_add_param.dart';
import '../repository/customer_repository.dart';

class CustomerAddUseCase implements UseCase<bool, CustomerAddParam> {
  final CustomerRepository customerRepository;

  const CustomerAddUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<DatabaseFailure, bool>> call(CustomerAddParam params) {
    return customerRepository.addCustomer(params);
  }
}
