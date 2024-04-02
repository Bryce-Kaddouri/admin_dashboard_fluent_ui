import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper/date_helper.dart';
import '../../../../core/helper/price_helper.dart';
import '../../data/model/order_model.dart';
import '../provider/order_provider.dart';
import '../widget/order_item_view_by_status_widget.dart';

class OrderDetailScreen extends StatelessWidget {
  final int orderId;
  final DateTime orderDate;

  const OrderDetailScreen({super.key, required this.orderId, required this.orderDate});

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      backgroundColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
      appBar: material.AppBar(
        leading: material.BackButton(
          onPressed: () async {
            context.pop();
          },
        ),
        centerTitle: true,
        shadowColor: FluentTheme.of(context).shadowColor,
        surfaceTintColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        backgroundColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        elevation: 4,
        title: Text('Order #${orderId}'),
        actions: [
          if (!orderDate.isBefore(DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)))
            Button(
              style: ButtonStyle(
                padding: ButtonState.all(EdgeInsets.zero),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: Icon(FluentIcons.edit, size: 20),
              ),
              onPressed: () {
                String orderDateStr = DateHelper.getFormattedDate(orderDate);
                context.go('/orders/${orderDateStr}/${orderId}/update');
              },
            ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: FutureBuilder<OrderModel?>(
        future: context.read<OrderProvider>().getOrderDetail(orderId, orderDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ProgressRing(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            print(snapshot.data);
            OrderModel orderModel = snapshot.data!;

            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.only(bottom: 50, left: 20, right: 20, top: 20),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    // rounded rectanmgle
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Icon(
                                    FluentIcons.event_date,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text('${DateHelper.getFormattedDateWithoutTime(orderModel!.date)}'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    // rounded rectanmgle
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Icon(
                                    FluentIcons.clock,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text('${DateHelper.get24HourTime(orderModel!.time)}'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    // rounded rectanmgle
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Icon(
                                    FluentIcons.contact,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text('${orderModel!.customer.fName} ${orderModel!.customer.lName}'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    // rounded rectanmgle
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Icon(
                                    FluentIcons.phone,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('${orderModel!.customer.countryCode}${orderModel!.customer.phoneNumber}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    // rounded rectanmgle
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Icon(
                                    FluentIcons.circle_dollar,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(text: '${orderModel.paidAmount}', style: TextStyle(fontWeight: FontWeight.bold, color: FluentTheme.of(context).typography.subtitle!.color)),
                                          TextSpan(text: ' / ', style: TextStyle(color: FluentTheme.of(context).typography.subtitle!.color)),
                                          TextSpan(text: '${orderModel.totalAmount}', style: TextStyle(color: FluentTheme.of(context).typography.subtitle!.color)),
                                        ])),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            // rounded rectanmgle
                                            shape: BoxShape.circle,
                                            color: orderModel.paidAmount == orderModel.totalAmount ? Colors.green : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: /*Text(
                                          '(${orderModel.paidAmount == orderModel.totalAmount ? 'Paid' : 'Unpaid: ${orderModel.totalAmount - orderModel.paidAmount} left'})'),*/
                                          RichText(
                                              text: TextSpan(children: [
                                        TextSpan(
                                          text: '(${orderModel.paidAmount == orderModel.totalAmount ? 'Paid' : 'Unpaid: '}',
                                          style: TextStyle(color: FluentTheme.of(context).typography.subtitle!.color),
                                        ),
                                        if (orderModel.paidAmount != orderModel.totalAmount) TextSpan(text: '${orderModel.totalAmount - orderModel.paidAmount}', style: TextStyle(fontWeight: FontWeight.bold, color: FluentTheme.of(context).typography.subtitle!.color)),
                                        TextSpan(text: ' left)', style: TextStyle(color: FluentTheme.of(context).typography.subtitle!.color)),
                                      ])),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: StatusWidget(status: orderModel.status.name)),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Items', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                        children: List.generate(orderModel!.cart.length, (index) {
                          return Card(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: Container(
                                  child: Image(
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox();
                                    },
                                    image: NetworkImage(orderModel!.cart[index].product.imageUrl),
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: Text('${orderModel!.cart[index].product.name}'),
                                subtitle: Text('${orderModel!.cart[index].product.price}'),
                                trailing: Text(orderModel!.cart[index].quantity.toString()),
                              ));
                        }),
                      ),
                    ],
                  )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount'),
                          Text(PriceHelper.getFormattedPrice(orderModel.totalAmount)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('No data found'),
            );
          }
        },
      ),
    );
  }
}
