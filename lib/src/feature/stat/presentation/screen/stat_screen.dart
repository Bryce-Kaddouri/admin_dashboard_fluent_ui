import 'package:admin_dashboard/src/feature/stat/data/datasource/stat_datasource.dart';
import 'package:admin_dashboard/src/feature/stat/data/model/stat_order_by_customer.dart';
import 'package:admin_dashboard/src/feature/stat/presentation/widget/pie_chart_widget.dart';
import 'package:flutter/material.dart';

import '../../data/model/stat_order_by_categ_model.dart';
import '../widget/simple_char_bar_widget.dart';

class StatScreen extends StatelessWidget {
  StatScreen({super.key});

  DateTime fromDate = DateTime.now().subtract(Duration(days: 30));
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
      child: FutureBuilder(
        future: Future.wait([
          StatDataSource().getOrdersStatByCustomer(),
          StatDataSource().getOrdersStatByCategory(fromDate, toDate),
        ]),
        builder: (context, snapshot){
          print('snapshot: $snapshot');
          print(snapshot.data);
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }else{
            if(snapshot.hasData){
              List<StatOrderByCustomer> statOrderByCustomerList = snapshot.data![0] as List<StatOrderByCustomer>;
              List<StatOrderByCategoryModel> statOrderByCategoryModelList = snapshot.data![1] as List<StatOrderByCategoryModel>;

              print('statOrderByCustomerList: $statOrderByCustomerList');
              print('statOrderByCategoryModelList: $statOrderByCategoryModelList');
              return Container(
                child:Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child:SimpleBarChartWidget(
                        statOrderByCustomerList: statOrderByCustomerList,
                      ),
                    ),
                    Container(

                      child:PieChartWidget(
                        lstData: statOrderByCategoryModelList,
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return const Center(child: Text('No data'));
            }
          }

        },
      ),
    ),
    );
  }
}

