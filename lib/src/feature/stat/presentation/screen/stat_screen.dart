import 'package:admin_dashboard/src/feature/stat/data/datasource/stat_datasource.dart';
import 'package:admin_dashboard/src/feature/stat/data/model/product_orice_history_model.dart';
import 'package:admin_dashboard/src/feature/stat/data/model/stat_order_by_customer.dart';
import 'package:admin_dashboard/src/feature/stat/presentation/widget/line_chart_product_price_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import material
import 'package:flutter/material.dart' as material;

import '../../../../core/helper/date_helper.dart';
import '../../data/model/stat_order_by_categ_model.dart';
import '../widget/pie_chart_widget.dart';
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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: Future.wait([
          StatDataSource().getOrdersStatByCustomer(selectedFilter),
          StatDataSource().getOrdersStatByCategory(fromDate, toDate),
          StatDataSource().getAllProductsPriceHistory(),
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
              List<ProductPriceHistoryModel> productPriceHistoryModelList = snapshot.data![2] as List<ProductPriceHistoryModel>;

              print('statOrderByCustomerList: $statOrderByCustomerList');
              print('statOrderByCategoryModelList: $statOrderByCategoryModelList');
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 145,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.custom(
                        pageSnapping: true,
                        scrollDirection: Axis.vertical,
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == 0) {
                              return Column(children: [
                                Acrylic(
                                  elevation: 4.0,
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    width: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('Price history'),
                                            ],
                                          ),
                                        ),
                                        if (productPriceHistoryModelList.isNotEmpty)
                                          Container(
                                            height: 40,
                                            width: 150,
                                            child: EditableComboBox<int>(
                                              value: currentIndex,
                                              items: List.generate(
                                                  productPriceHistoryModelList.length,
                                                  (index) => ComboBoxItem(
                                                        child: Container(height: 40, width: 150, padding: const EdgeInsets.all(8.0), child: Text(productPriceHistoryModelList[index].productName)),
                                                        value: index,
                                                      )),
                                              onChanged: (value) => setState(() {
                                                currentIndex = value!;
                                              }),
                                              onFieldSubmitted: (String text) {
                                                print('text: $text');
                                                return text;
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Expanded(
                                  /* height: MediaQuery.of(context).size.height - 145,
                                  width: MediaQuery.of(context).size.width,*/
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ScrollableChartScreen(
                                      data: productPriceHistoryModelList,
                                      currentIndex: currentIndex,
                                    ),
                                  ),
                                ),
                              ]
                                  /*Column(
                                  children: [
                                    Acrylic(
                                      elevation: 4.0,
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        width: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text('Price history'),
                                                ],
                                              ),
                                            ),
                                            if (productPriceHistoryModelList.isNotEmpty)
                                              ComboBox<int>(
                                                value: currentIndex,
                                                items: List.generate(
                                                    productPriceHistoryModelList.length,
                                                    (index) => ComboBoxItem(
                                                          child: ListTile(
                                                            leading: CircleAvatar(
                                                              backgroundImage: NetworkImage(productPriceHistoryModelList[index].productImageUrl),
                                                            ),
                                                            title: Text(productPriceHistoryModelList[index].productName),
                                                          ),
                                                          value: index,
                                                        )),
                                                onChanged: (value) => setState(() {
                                                  currentIndex = value!;
                                                }),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: Acrylic(
                                        elevation: 4.0,
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          padding: const EdgeInsets.all(16.0),
                                          child: ScrollableChartScreen(
                                            data: productPriceHistoryModelList,
                                            currentIndex: currentIndex,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                                  );
                            } else if (index == 1) {
                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width,
                                color: Colors.blue,
                                child: Column(
                                  children: [
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
                                                  Text('From: ${DateHelper.getFormattedDate(fromDate)}'),
                                                  Text('To: ${DateHelper.getFormattedDate(toDate)}'),
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
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: Acrylic(
                                        elevation: 4.0,
                                        child: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          width: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.width,
                                          child: PieChartWidget(
                                            lstData: statOrderByCategoryModelList,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width,
                                color: Colors.red,
                                child: Column(children: [
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
                                  SizedBox(height: 8.0),
                                  Expanded(
                                    child: Acrylic(
                                      elevation: 4.0,
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        width: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.width,
                                        child: SimpleBarChartWidget(
                                          isTotalAmount: selectedFilter == 'total_amount',
                                          statOrderByCustomerList: statOrderByCustomerList,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            }
                          },
                          childCount: 3,
                        ),
                        /*children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.red,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                      ),*/
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 60,
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                            style: ButtonStyle(
                              padding: ButtonState.all(EdgeInsets.zero),
                            ),
                            child: Container(
                              height: 32,
                              width: 32,
                              child: const Icon(FluentIcons.chevron_left),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(width: 8.0),
                          RichText(
                            text: TextSpan(
                              text: 'Page 1 of 2',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Button(
                            style: ButtonStyle(
                              padding: ButtonState.all(EdgeInsets.zero),
                            ),
                            child: Container(
                              height: 32,
                              width: 32,
                              child: const Icon(FluentIcons.chevron_right),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /*Column(
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
                  ),*/
              );
            } else {
              return const Center(child: Text('No data'));
            }
          }
        },
      ),
    );
  }
}
