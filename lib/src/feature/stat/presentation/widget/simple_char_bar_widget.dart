/// Bar chart example
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../data/model/stat_order_by_customer.dart';

class SimpleBarChartWidget extends StatelessWidget {

  final List<StatOrderByCustomer> statOrderByCustomerList ;

  const SimpleBarChartWidget({super.key, required this.statOrderByCustomerList});

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(List<StatOrderByCustomer> lstData) {
    final data = lstData.map((e) => OrdinalSales('${e.fNameCustomer} ${e.lNameCustomer}', e.count)).toList();

    /*[
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];*/

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  charts.BarChart(
      _createSampleData(statOrderByCustomerList),
      animate: true,
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
