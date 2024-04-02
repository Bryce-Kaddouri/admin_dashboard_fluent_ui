import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/order_model.dart';
import '../repository/order_repository.dart';

class OrderGetOrdersByDateUseCase implements UseCase<List<OrderModel>, DateTime> {
  final OrderRepository orderRepository;

  const OrderGetOrdersByDateUseCase({
    required this.orderRepository,
  });

  @override
  Future<Either<DatabaseFailure, List<OrderModel>>> call(DateTime date) {
    return orderRepository.getOrdersByDate(date);
  }
}
