import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:provider/provider.dart';

import '../../../../core/helper/date_helper.dart';
import '../../data/model/order_model.dart';
import '../provider/order_provider.dart';
import '../widget/order_item_view_by_status_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

// keep alive mixin
class _OrderScreenState extends State<OrderScreen> with AutomaticKeepAliveClientMixin {
  ScrollController _mainScrollController = ScrollController();
  ScrollController _testController = ScrollController();
  List<DateTime> lstWeedDays = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      lstWeedDays = DateHelper.getDaysInWeek(context.read<OrderProvider>().selectedDate);
    });
  }

  Future<DateTime?> selectDate() async {
    // global key for the form
    /*return material.showDatePicker(
        context: context,
        currentDate: context.read<OrderProvider>().selectedDate,
        initialDate: context.read<OrderProvider>().selectedDate,
        // first date of the year
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365)));*/

    return await showDialog<DateTime?>(
        context: context,
        builder: (context) {
          DateTime selectedDate = context.read<OrderProvider>().selectedDate;
          return ContentDialog(
            title: Container(
              alignment: Alignment.center,
              child: Text(
                'Select Date',
              ),
            ),
            content: material.Card(
              surfaceTintColor: FluentTheme.of(context).navigationPaneTheme.overlayBackgroundColor,
              elevation: 4,
              margin: EdgeInsets.zero,
              child: material.CalendarDatePicker(
                initialDate: context.read<OrderProvider>().selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateChanged: (DateTime value) {
                  selectedDate = value;
                },
              ),
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context, selectedDate);
                },
                child: Text('Confirm'),
              ),
              Button(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      backgroundColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
      appBar: material.AppBar(
        shadowColor: FluentTheme.of(context).shadowColor,
        surfaceTintColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        backgroundColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        elevation: 0,
        /* leading: material.BackButton(
          onPressed: () {
            context.go('/');
          },
        ),*/
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateHelper.getFormattedDateWithoutTime(context.watch<OrderProvider>().selectedDate, isShort: true)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              DateTime now = DateTime.now();
              context.read<OrderProvider>().setSelectedDate(now);
            },
            icon: const Icon(FluentIcons.goto_today, size: 30),
          ),
          IconButton(
            onPressed: () async {
              await selectDate().then((value) {
                if (value != null) {
                  context.read<OrderProvider>().setSelectedDate(value);
                  setState(() {
                    lstWeedDays = DateHelper.getDaysInWeek(value);
                  });
                }
              });
            },
            icon: const Icon(FluentIcons.event_date, size: 30),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      /*drawer: DrawerWidget(
        orderDate: context.watch<OrderProvider>().selectedDate,
      ),*/
      body: CustomScrollView(controller: _mainScrollController, slivers: [
        FutureBuilder(
          future: context.read<OrderProvider>().getOrdersByDate(context.watch<OrderProvider>().selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> lstHourMap = [];

                List<OrderModel> orderList = snapshot.data as List<OrderModel>;
                List<int> lstHourDistinct = orderList.map((e) => e.time.hour).toSet().toList();
                print('order list length');
                print(orderList.length);

                for (var hour in lstHourDistinct) {
                  List<OrderModel> orderListOfTheHour = orderList.where((element) => element.time.hour == hour).toList();

                  Map<String, dynamic> map = {
                    'hour': hour,
                    'order': orderListOfTheHour,
                  };
                  lstHourMap.add(map);
                }

                if (lstHourMap.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                      alignment: Alignment.center,
                      child: Text("No order found for this date"),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Map<String, dynamic> data = lstHourMap[index];
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: Expander(
                          initiallyExpanded: true,
                          header: Container(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${DateHelper.get24HourTime(material.TimeOfDay(hour: data['hour'], minute: 0))}',
                                  style: FluentTheme.of(context).typography.subtitle!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                RichText(
                                    text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${data['order'].length}',
                                      style: FluentTheme.of(context).typography.subtitle!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    TextSpan(
                                      text: ' orders',
                                      style: FluentTheme.of(context).typography.subtitle!.copyWith(
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          content: Column(
                            children: List.generate(
                              data['order'].length,
                              (index) => OrdersItemViewByStatus(
                                status: data['order'][index].status.name,
                                order: data['order'][index],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: lstHourDistinct.length,
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("No order"),
                  ),
                );
              }
            } else {
              return SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height - 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: ProgressRing(),
                ),
              );
            }
          },
        )
      ]),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}

class HorizontalSliverList extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets listPadding;
  final Widget? divider;

  const HorizontalSliverList({
    required this.children,
    this.listPadding = const EdgeInsets.all(8),
    this.divider,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: listPadding,
          child: Row(children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) addDivider(),
            ],
          ]),
        ),
      ),
    );
  }

  Widget addDivider() => divider ?? Padding(padding: const EdgeInsets.symmetric(horizontal: 8));
}
