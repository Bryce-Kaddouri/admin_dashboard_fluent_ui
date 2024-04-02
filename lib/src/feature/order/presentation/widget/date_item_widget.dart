import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper/date_helper.dart';
import '../provider/order_provider.dart';

class DateItemWidget extends StatefulWidget {
  DateTime selectedDate;
  DateTime dateItem;
  bool isToday;
  DateItemWidget(
      {super.key,
      required this.selectedDate,
      required this.dateItem,
      required this.isToday});

  @override
  State<DateItemWidget> createState() => _DateItemWidgetState();
}

class _DateItemWidgetState extends State<DateItemWidget> {
  @override
  Widget build(BuildContext context) {
    print('*' * 50);
    print('selectedDate: ${widget.selectedDate}');
    print('dateItem: ${widget.dateItem}');
    print('isToday: ${widget.isToday}');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: widget.isToday ? 5 : 0,
      color: widget.isToday ? Colors.white : Colors.transparent,
      child: InkWell(
        onTap: () {
          print('DateItemWidget: onTap');
          context.read<OrderProvider>().setSelectedDate(widget.dateItem);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: widget.isToday ? 70 : 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isToday)
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              Text(
                widget.dateItem.day.toString(),
                style: TextStyle(
                  color: widget.isToday ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                DateHelper.getDayInLetter(widget.dateItem),
                style: TextStyle(
                    color: widget.isToday ? Colors.black : Colors.grey,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
