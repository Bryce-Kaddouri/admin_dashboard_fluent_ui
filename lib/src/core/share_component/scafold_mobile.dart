import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:admin_dashboard/src/feature/customer/presentation/provider/customer_provider.dart';
import 'package:admin_dashboard/src/feature/product/presentation/provider/product_provider.dart';
import 'package:admin_dashboard/src/feature/user/presentation/provider/user_provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ScaffoldMobile extends fluent.StatefulWidget {
  final String title;
  final Widget child;
  final int selectedIndex;
  const ScaffoldMobile(
      {super.key,
      required this.title,
      required this.child,
      required this.selectedIndex});

  @override
  fluent.State<ScaffoldMobile> createState() => _ScaffoldMobileState();
}

class _ScaffoldMobileState extends fluent.State<ScaffoldMobile> {
  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().getUserModel();
  }

  @override
  Widget build(BuildContext context) {
    print('selectedIndex: ${widget.selectedIndex}');
    return Scaffold(
      backgroundColor:
          fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor,
      drawer: Drawer(
        backgroundColor: fluent.FluentTheme.of(context)
            .navigationPaneTheme
            .overlayBackgroundColor,
        surfaceTintColor: fluent.FluentTheme.of(context)
            .navigationPaneTheme
            .overlayBackgroundColor,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: fluent.FluentTheme.of(context).menuColor,
                    ),
                  ),
                  color: fluent.FluentTheme.of(context).menuColor,
                ),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      fluent.CircleAvatar(
                        radius: 50,
                        child: Icon(fluent.FluentIcons.contact),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '${context.read<AuthProvider>().currentUser!.firstName ?? ''} ${context.read<AuthProvider>().currentUser!.lastName ?? ''}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    fluent.ListTile.selectable(
/*
                      selectedColor: Colors.red,
*/

                      selected: widget.selectedIndex == 1,
                      title: Text('Home'),
                      leading: Icon(fluent.FluentIcons.home),
                      onPressed: () {
                        context.go('/');
                        Navigator.of(context).pop();
                      },
                    ),
                    ExpansionTile(
                      onExpansionChanged: (value) {
                        context.read<CategoryProvider>().setExpanded(value);
                      },
                      initiallyExpanded:
                          context.watch<CategoryProvider>().isExpanded,
                      title: Text('Category'),
                      children: [
                        fluent.ListTile.selectable(
                            selected: widget.selectedIndex == 2,
                            title: Text('Category List'),
                            leading: Icon(fluent.FluentIcons.list),
                            onPressed: () {
                              context.go('/category');
                              Navigator.of(context).pop();
                            }),
                        fluent.ListTile.selectable(
                          title: Text('Category Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 3,
                          onPressed: () {
                            context.go('/category/add');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.category_classification),
                    ),
                    ExpansionTile(
                      onExpansionChanged: (value) {
                        context.read<ProductProvider>().setExpanded(value);
                      },
                      initiallyExpanded:
                          context.watch<ProductProvider>().isExpanded,
                      title: Text('Product'),
                      children: [
                        fluent.ListTile.selectable(
                          title: Text('Product List'),
                          leading: Icon(fluent.FluentIcons.list),
                          selected: widget.selectedIndex == 5,
                          onPressed: () {
                            context.go('/product');
                            Navigator.of(context).pop();
                          },
                        ),
                        fluent.ListTile.selectable(
                          title: Text('Product Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 6,
                          onPressed: () {
                            context.go('/product/add');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.product),
                    ),
                    ExpansionTile(
                      title: Text('Order'),
                      children: [
                        fluent.ListTile.selectable(
                          onPressed: () {
                            context.go('/orders/track');
                            Navigator.of(context).pop();
                          },
                          title: Text('Track Errors'),
                          leading: Icon(fluent.FluentIcons.trackers),
                          selected: widget.selectedIndex == 6,
                        ),
                        fluent.ListTile.selectable(
                          onPressed: () {
                            context.go('/orders');
                            Navigator.of(context).pop();
                          },
                          title: Text('Order List'),
                          leading: Icon(fluent.FluentIcons.issue_tracking),
                          selected: widget.selectedIndex == 7,
                        ),
                        fluent.ListTile.selectable(
                          onPressed: () {
                            context.go('/orders/chart');
                            Navigator.of(context).pop();
                          },
                          title: Text('Order Chart'),
                          leading: Icon(fluent.FluentIcons.chart),
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.clipboard_list),
                    ),
                    ExpansionTile(
                      onExpansionChanged: (value) {
                        context.read<UserProvider>().setExpanded(value);
                      },
                      initiallyExpanded:
                          context.watch<UserProvider>().isExpanded,
                      title: Text('User'),
                      children: [
                        fluent.ListTile.selectable(
                          title: Text('User List'),
                          leading: Icon(fluent.FluentIcons.list),
                          selected: widget.selectedIndex == 12,
                          onPressed: () {
                            context.go('/user');
                            Navigator.of(context).pop();
                          },
                        ),
                        fluent.ListTile.selectable(
                          title: Text('User Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 13,
                          onPressed: () {
                            context.go('/user/add');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.account_management),
                    ),
                    ExpansionTile(
                      onExpansionChanged: (value) {
                        context.read<CustomerProvider>().setExpanded(value);
                      },
                      initiallyExpanded:
                          context.watch<CustomerProvider>().isExpanded,
                      title: Text('Customer'),
                      children: [
                        fluent.ListTile.selectable(
                          title: Text('Customer List'),
                          leading: Icon(fluent.FluentIcons.list),
                          selected: widget.selectedIndex == 15,
                          onPressed: () {
                            context.go('/customer');
                            Navigator.of(context).pop();
                          },
                        ),
                        fluent.ListTile.selectable(
                          title: Text('Customer Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 16,
                          onPressed: () {
                            context.go('/customer/add');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      leading: Icon(
                          fluent.FluentIcons.hexadite_investigation_semi_auto),
                    ),
                    ExpansionTile(
                      title: Text('Catalog'),
                      children: [
                        fluent.ListTile.selectable(
                          title: Text('Page List'),
                          leading: Icon(fluent.FluentIcons.list),
                          selected: widget.selectedIndex == 12,
                        ),
                        fluent.ListTile.selectable(
                          title: Text('Page Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 13,
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.book_answers),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    fluent.ListTile.selectable(
                      title: Text('Setting'),
                      leading: Icon(fluent.FluentIcons.settings),
                      selected: widget.selectedIndex == 14,
                      onPressed: () {
                        context.go('/setting');
                        Navigator.of(context).pop();
                      },
                    ),
                    fluent.ListTile.selectable(
                      title: Text('Logout'),
                      leading: Icon(fluent.FluentIcons.sign_out),
                      selected: widget.selectedIndex == 15,
                      onPressed: () {
                        context
                            .read<AuthProvider>()
                            .logout()
                            .then((value) => context.go('/login'));
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 4,
        shadowColor: fluent.FluentTheme.of(context).shadowColor,
        surfaceTintColor:
            fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        backgroundColor:
            fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: widget.child,
    );
  }
}
