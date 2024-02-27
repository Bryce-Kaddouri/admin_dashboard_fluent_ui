import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/customer_repository.dart';

class CustomerDeleteUseCase implements UseCase<bool, int> {
  final CustomerRepository customerRepository;

  const CustomerDeleteUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<DatabaseFailure, bool>> call(int id) {
    return customerRepository.deleteCustomer(id);
  }
}
