import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../business/param/get_order_by_id_param.dart';
import '../../business/repository/order_repository.dart';
import '../datasource/order_datasource.dart';
import '../model/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource orderDataSource;

  OrderRepositoryImpl({
    required this.orderDataSource,
  });

  @override
  Future<Either<DatabaseFailure, OrderModel>> getOrderById(GetOrderByIdParam param) async {
    return await orderDataSource.getOrderById(param.orderId, param.date);
  }

  @override
  Future<Either<DatabaseFailure, List<OrderModel>>> getOrdersByCustomerId(int customerId) async {
    return await orderDataSource.getOrdersByCustomerId(customerId);
  }

  @override
  Future<Either<DatabaseFailure, List<OrderModel>>> getOrdersByDate(DateTime date) async {
    return await orderDataSource.getOrdersByDate(date);
  }
}
