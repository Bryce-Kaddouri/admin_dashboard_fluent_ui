import 'package:admin_dashboard/src/feature/stat/data/model/stat_order_by_customer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/stat_order_by_categ_model.dart';

class StatDataSource{
  final _client = Supabase.instance.client;



  Future<List<StatOrderByCategoryModel>?> getOrdersStatByCategory(
      DateTime startDate, DateTime endDate) async {
    try {
      final response = await _client
          .rpc('get_orders_stat_by_categ', params: {
        'from_date': startDate.toIso8601String(),
        'to_date': endDate.toIso8601String(),
      })
          .select().order('total_quantity', ascending: false).limit(10);

      List<StatOrderByCategoryModel> statOrderByCategoryModelList = [];
      if (response.isNotEmpty) {
        for (var item in response) {
          statOrderByCategoryModelList.add(StatOrderByCategoryModel.fromJson(item));
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

  Future<List<StatOrderByCustomer>?> getOrdersStatByCustomer()async{
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
      final response =await _client.from('orders_stat_by_customer').select().order('count', ascending: false);

      List<StatOrderByCustomer> statOrderByCustomerList = [];
      if (response.isNotEmpty) {
        for (var item in response) {
          statOrderByCustomerList.add(StatOrderByCustomer.fromJson(item));
        }
      }
      return statOrderByCustomerList;
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
}