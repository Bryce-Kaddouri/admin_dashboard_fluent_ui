import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../data/model/order_model.dart';
import '../param/get_order_by_id_param.dart';

abstract class OrderRepository {
  Future<Either<DatabaseFailure, List<OrderModel>>> getOrdersByDate(DateTime date);

  Future<Either<DatabaseFailure, List<OrderModel>>> getOrdersByCustomerId(int customerId);

  Future<Either<DatabaseFailure, OrderModel>> getOrderById(GetOrderByIdParam param);
}
