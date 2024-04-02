import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper/date_helper.dart';
import '../../data/model/order_model.dart';
import '../provider/order_provider.dart';
import '../widget/date_item_widget.dart';
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
    return material.showDatePicker(
        context: context,
        currentDate: context.read<OrderProvider>().selectedDate,
        initialDate: context.read<OrderProvider>().selectedDate,
        // first date of the year
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365)));
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
        leading: material.BackButton(
          onPressed: () {
            context.go('/');
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateHelper.getMonthNameAndYear(context.watch<OrderProvider>().selectedDate)),
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
        material.SliverPersistentHeader(
          floating: true,
          delegate: HeaderDelegate(
            child: Container(
              child: Stack(
                children: [
                  /*Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: FluentTheme.of(context).shadowColor,
                          offset: Offset(0, 1),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),*/
                  material.Card(
                    shadowColor: FluentTheme.of(context).shadowColor,
                    margin: EdgeInsets.all(0),
                    shape: material.RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    elevation: 2,
                    child: Container(
                      color: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
                      height: 70,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    height: 80,
                    /*gradient: LinearGradient(
                  stops: [
                    0.0,
                    0.9,
                    0.9,
                    1.0,
                  ],
                  colors: [
                    FluentTheme.of(context).navigationPaneTheme.backgroundColor!,
                    FluentTheme.of(context).navigationPaneTheme.backgroundColor!,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),*/

                    width: double.infinity,
                    child: DateListWidget(
                      lstWeedDays: lstWeedDays,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
                          header: Container(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${DateHelper.get24HourTime(material.TimeOfDay(hour: data['hour'], minute: 0))}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${data['order'].length}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' orders',
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

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  const HeaderDelegate({
    required this.child,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class DateListWidget extends StatelessWidget {
  final List<DateTime> lstWeedDays;

  DateListWidget({
    super.key,
    required this.lstWeedDays,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        7,
        (index) {
          DateTime dateItem = lstWeedDays[index];
          print('test: ' + index.toString());
          print(dateItem);

          print(dateItem.day);

          return Expanded(
            child: DateItemWidget(
              selectedDate: context.watch<OrderProvider>().selectedDate,
              dateItem: dateItem,
              isToday: dateItem.day == context.watch<OrderProvider>().selectedDate.day,
            ),
          );
        },
      ),
    );
  }
}
