import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../model/order_model.dart';

class OrderDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, List<OrderModel>>> getOrdersByDate(DateTime date) async {
    try {
      var response = await _client.from('all_orders_view').select().eq('order_date', date.toIso8601String()).order('order_time', ascending: true);
      print('response from getOrders');
      print(response);

      if (response.isNotEmpty) {
        List<OrderModel> orderList = response.map((e) => OrderModel.fromJson(e)).toList();
        print('order list');
        print(orderList);
        return Right(orderList);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting orders'));
      }
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print('e');

      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting orders'));
    }
  }

  Future<Either<DatabaseFailure, List<OrderModel>>> getOrdersByCustomerId(int customerId) async {
    print('getOrdersBySupplierId');
    try {
      // where order_date >= current_date

      List<Map<String, dynamic>> responseFuture = await _client.from('all_orders_view').select().gte('order_date', DateTime.now().toIso8601String()).eq('customer ->> customer_id', customerId).order('order_time', ascending: true);
      print('responseFuture');
      print(responseFuture);

      List<Map<String, dynamic>> responseOld = await _client.from('order_history').select().lt('order_date', DateTime.now().toIso8601String()).eq('customer ->> customer_id', customerId).order('order_time', ascending: true);
      print('responseOld');
      print(responseOld);
      /*
          response = response.where((element) => element['customer']['customer_id'] == supplierId).toList();
*/
      List<OrderModel> orderList = [];

      if (responseFuture.isNotEmpty) {
        orderList = responseFuture.map((e) => OrderModel.fromJson(e)).toList();
      }

      if (responseOld.isNotEmpty) {
        orderList.addAll(responseOld.map((e) => OrderModel.fromJson(e)).toList());
      }

      return Right(orderList);
      /*.from('all_orders_view')
          .select();*/
/*
          .eq('supplier_id', supplierId)
*/
/*
          .order('order_time', ascending: true);
*/
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting orders'));
    }
  }

  Future<Either<DatabaseFailure, OrderModel>> getOrderById(int orderId, DateTime date) async {
    try {
      List<Map<String, dynamic>> response = [];
      if (date.isBefore(DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0))) {
        response = await _client.from('order_history').select().eq('order_id', orderId).eq('order_date', date.toIso8601String());
      } else {
        response = await _client.from('all_orders_view').select().eq('order_id', orderId).eq('order_date', date.toIso8601String());
      }
      print('response from getOrderById');
      print(response);

      if (response.isNotEmpty) {
        OrderModel order = OrderModel.fromJson(response[0]);
        print('order');
        print(order);
        return Right(order);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting order'));
      }
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print('e');

      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting order'));
    }
  }
}
