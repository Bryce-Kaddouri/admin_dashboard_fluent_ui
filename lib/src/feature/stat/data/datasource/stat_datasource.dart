import 'package:admin_dashboard/src/feature/stat/data/model/product_orice_history_model.dart';
import 'package:admin_dashboard/src/feature/stat/data/model/stat_order_by_customer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/stat_order_by_categ_model.dart';

class StatDataSource {
  final _client = Supabase.instance.client;

  Future<List<StatOrderByDayModel>?> getOrdersStatByCategory(DateTime startDate, DateTime endDate) async {
    try {
      final response = await _client.rpc('get_orders_stats_by_day', params: {
        'optional_start_date': startDate.toIso8601String(),
        'optional_end_date': endDate.toIso8601String(),
      }).select();

      List<StatOrderByDayModel> statOrderByCategoryModelList = [];
      if (response.isNotEmpty) {
        print(response);
        for (var item in response) {
          if (item['order_count'] > 0) {
            statOrderByCategoryModelList.add(StatOrderByDayModel.fromJson(item));
          }
        }
      }

      return statOrderByCategoryModelList;
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return /*Left(DatabaseFailure(errorMessage: 'Error adding category'));*/
          null;
    } catch (e) {
      print(e);
      return /*Left(DatabaseFailure(errorMessage: 'Error adding category'));*/
          null;
    }
  }

  Future<List<StatOrderByCustomer>> getOrdersStatByCustomer(String orderBy) async {
    /*dynamic response =
    await _client.from('orders_stat_by_customer').select().order('count', ascending: false);
    List<StatOrderByCustomer> statOrderByCustomerList = [];
    if (response.isNotEmpty) {
      for (var item in response) {
        statOrderByCustomerList.add(StatOrderByCustomer.fromJson(item));
      }
    }
    print(response);
    return statOrderByCustomerList;*/

    try {
      final response = await _client.from('orders_stat_by_customer').select().order(orderBy, ascending: false).limit(10);
      print(response);

      List<StatOrderByCustomer> statOrderByCustomerList = [];
      if (response.isNotEmpty) {
        for (var item in response) {
          statOrderByCustomerList.add(StatOrderByCustomer.fromJson(item));
        }
      }
      print(statOrderByCustomerList);
      return statOrderByCustomerList;
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<ProductPriceHistoryModel>?> getAllProductsPriceHistory() async {
    try {
      final response = await _client.from('price_history_view').select();
      print('price history view');
      print(response);

      List<ProductPriceHistoryModel> statOrderByCustomerList = [];
      if (response.isNotEmpty) {
        print(response.length);
        for (var item in response) {
          print('--' * 20);
          print(item);

          ProductPriceHistoryModel model = ProductPriceHistoryModel.fromJson(item);
          statOrderByCustomerList.add(model);
        }
      }
      print(statOrderByCustomerList.length);
      return statOrderByCustomerList;
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return /*Left(DatabaseFailure(errorMessage: 'Error adding category'));*/
          null;
    } catch (e) {
      print('error for product price');
      print(e);
      return /*Left(DatabaseFailure(errorMessage: 'Error adding category'));*/
          null;
    }
  }
}
