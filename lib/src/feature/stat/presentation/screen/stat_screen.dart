import 'package:admin_dashboard/src/feature/stat/data/datasource/stat_datasource.dart';
import 'package:admin_dashboard/src/feature/stat/data/model/stat_order_by_customer.dart';
import 'package:admin_dashboard/src/feature/stat/presentation/widget/pie_chart_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

import '../../data/model/stat_order_by_categ_model.dart';
import '../widget/simple_char_bar_widget.dart';

class StatScreen extends StatefulWidget {
  StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  DateTime fromDate = DateTime.now().subtract(Duration(days: 30));

  DateTime toDate = DateTime.now();
  String selectedFilter = 'count';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: FutureBuilder(
          future: Future.wait([
            StatDataSource().getOrdersStatByCustomer(selectedFilter),
            StatDataSource().getOrdersStatByCategory(fromDate, toDate),
          ]),
          builder: (context, snapshot) {
            print('snapshot: $snapshot');
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: ProgressRing());
            } else {
              if (snapshot.hasData) {
                List<StatOrderByCustomer> statOrderByCustomerList = snapshot.data![0] as List<StatOrderByCustomer>;
                List<StatOrderByDayModel> statOrderByCategoryModelList = snapshot.data![1] as List<StatOrderByDayModel>;

                print('statOrderByCustomerList: $statOrderByCustomerList');
                print('statOrderByCategoryModelList: $statOrderByCategoryModelList');
                return Container(
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      Acrylic(
                        elevation: 4.0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Top 10 customers'),
                                  ],
                                ),
                              ),
                              ComboBox<String>(
                                value: selectedFilter,
                                items: [
                                  ComboBoxItem(
                                    child: Text('Total orders'),
                                    value: 'count',
                                  ),
                                  ComboBoxItem(
                                    child: Text('Total amount'),
                                    value: 'total_amount',
                                  ),
                                ],
                                onChanged: (value) => setState(() {
                                  selectedFilter = value!;
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Acrylic(
                        elevation: 4.0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.width,
                          child: SimpleBarChartWidget(
                            isTotalAmount: selectedFilter == 'total_amount',
                            statOrderByCustomerList: statOrderByCustomerList,
                          ),
                        ),
                      ),
                      SizedBox(height: 100.0),
                      Acrylic(
                        elevation: 4.0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('From: ${fromDate.toIso8601String()}'),
                                    Text('To: ${toDate.toIso8601String()}'),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(FluentIcons.calendar),
                                onPressed: () async {
                                  // range picker
                                  material.showDateRangePicker(context: context, firstDate: DateTime.now().subtract(Duration(days: 365)), lastDate: DateTime.now(), initialDateRange: DateTimeRange(start: fromDate, end: toDate)).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        fromDate = value.start;
                                        toDate = value.end;
                                      });
                                      print('fromDate: $fromDate');
                                      print('toDate: $toDate');
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Acrylic(
                        elevation: 4.0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.width,
                          child: PieChartWidget(
                            lstData: statOrderByCategoryModelList,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No data'));
              }
            }
          },
        ),
      ),
    );
  }
}
