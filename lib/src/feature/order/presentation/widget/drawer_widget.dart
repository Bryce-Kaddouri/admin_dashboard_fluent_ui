import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/date_helper.dart';

class DrawerWidget extends StatefulWidget {
  final DateTime orderDate;
  const DrawerWidget({super.key, required this.orderDate});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Drawer Header"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          fluent.ListTile.selectable(
            contentAlignment: CrossAxisAlignment.center,
            selected: true,
            title: Container(
              alignment: Alignment.center,
              height: 40,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Icon(fluent.FluentIcons.product_list, size: 28),
                  ),
                  Text("Order List", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            onPressed: () {},
          ),
          fluent.ListTile.selectable(
            /*leading: Icon(fluent.FluentIcons.product_release, size: 32),
            title: Text("Add Order"),*/
            title: Container(
              alignment: Alignment.center,
              height: 40,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Icon(fluent.FluentIcons.product_release, size: 28),
                  ),
                  Text("Add Order", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            onPressed: () {
              print('add order');
              context.go('/orders/add');
            },
          ),
          fluent.ListTile.selectable(
            /*leading: Icon(fluent.FluentIcons.streaming, size: 32),
            title: Text("Track Order"),*/
            title: Container(
              alignment: Alignment.center,
              height: 40,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Icon(fluent.FluentIcons.streaming, size: 28),
                  ),
                  Text("Track Order", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            onPressed: () {
              print('add order');
              String date = DateHelper.getFormattedDate(widget.orderDate);
              context.go('/track-order/$date');
            },
          ),
          fluent.ListTile.selectable(
            /* leading: Icon(fluent.FluentIcons.group, size: 32),
            title: Text("Customer List"),*/
            title: Container(
              alignment: Alignment.center,
              height: 40,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Icon(fluent.FluentIcons.group, size: 28),
                  ),
                  Text("Customer List", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            onPressed: () {
              context.go('/customers');
            },
          ),
          fluent.ListTile.selectable(
            /*leading: Icon(fluent.FluentIcons.add_group, size: 32),
            title: Text("Add Customer"),*/
            title: Container(
              alignment: Alignment.center,
              height: 40,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Icon(fluent.FluentIcons.add_group, size: 28),
                  ),
                  Text("Add Customer", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            onPressed: () {
              context.go('/customers/add');
            },
          ),
          fluent.ListTile.selectable(
            /*  leading: Icon(Icons.settings_outlined, size: 32),
            title: Text("Settings"),*/
            title: Container(
              alignment: Alignment.center,
              height: 40,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Icon(fluent.FluentIcons.settings, size: 28),
                  ),
                  Text("Settings", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            onPressed: () {
              print('setting');
              context.go('/setting');
            },
          ),
        ],
      ),
    );
  }
}
