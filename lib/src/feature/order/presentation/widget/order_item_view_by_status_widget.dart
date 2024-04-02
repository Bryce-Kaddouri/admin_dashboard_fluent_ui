import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/helper/date_helper.dart';
import '../../data/model/order_model.dart';

class StatusWidget extends StatelessWidget {
  final String status;
  const StatusWidget({super.key, required this.status});

  Color getBgColor() {
    switch (status) {
      case 'cancelled':
        return AppColor.canceledBackgroundColor;
      case 'pending':
        return AppColor.pendingBackgroundColor;
      case 'inProgress':
        return AppColor.cookingBackgroundColor;
      case 'completed':
        return AppColor.completedBackgroundColor;
      case 'collected':
        return AppColor.completedForegroundColor;
      default:
        return Colors.grey;
    }
  }

  Color getFgColor() {
    switch (status) {
      case 'cancelled':
        return AppColor.canceledForegroundColor;
      case 'pending':
        return AppColor.pendingForegroundColor;
      case 'inProgress':
        return AppColor.cookingForegroundColor;
      case 'completed':
        return AppColor.completedForegroundColor;
      case 'collected':
        return Colors.white;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: getBgColor(),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: getFgColor(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class OrdersItemViewByStatus extends StatelessWidget {
  final String status;
  final OrderModel order;
  final bool isTrackOrder;
  const OrdersItemViewByStatus({super.key, required this.status, required this.order, this.isTrackOrder = false});

  double getTotal(int index) {
    double total = 0;
    order.cart.forEach((element) {
      total += element.product.price * element.quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
/*
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
*/
      child: GestureDetector(
        onTap: () {
          int orderId = order.id!;
          DateTime orderDate = order.date;
          print(orderId);
          print(orderDate);
          String date = DateHelper.getFormattedDate(orderDate);
          if (isTrackOrder) {
            context.go('/track-order/$date/$orderId');
          } else {
            context.push('/orders/$date/$orderId');
          }
        },
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '#${order.id}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('${order.customer.lName} ${order.customer.fName}'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: StatusWidget(status: status),
                    ),
                  ),
                  /* Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child:
                                    Text('${orders[index].nbTotalItemsCart}'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text('${PriceHelper.getFormattedPrice(
                                  getTotal(index),
                                  showBefore: false,
                                )}'),
                              ),
                            ),*/
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        DateHelper.get24HourTime(order.time),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 40,
              child: Container(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(FluentIcons.forward),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
