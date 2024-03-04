import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
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
  Widget build(BuildContext context) {
    print('selectedIndex: ${widget.selectedIndex}');
    return Scaffold(
      drawer: Drawer(
        backgroundColor: fluent.FluentTheme.of(context)
            .navigationPaneTheme
            .overlayBackgroundColor,
        surfaceTintColor: fluent.FluentTheme.of(context)
            .navigationPaneTheme
            .overlayBackgroundColor,
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
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
                      },
                    ),
                    ExpansionTile(
                      title: Text('Category'),
                      children: [
                        fluent.ListTile.selectable(
                            selected: widget.selectedIndex == 2,
                            title: Text('Category List'),
                            leading: Icon(fluent.FluentIcons.list),
                            onPressed: () {
                              context.go('/category');
                            }),
                        fluent.ListTile.selectable(
                          title: Text('Category Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 3,
                          onPressed: () {
                            context.go('/category/add');
                          },
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.category_classification),
                    ),
                    ExpansionTile(
                      title: Text('Product'),
                      children: [
                        fluent.ListTile.selectable(
                          title: Text('Product List'),
                          leading: Icon(fluent.FluentIcons.list),
                          selected: widget.selectedIndex == 5,
                          onPressed: () {
                            context.go('/product');
                          },
                        ),
                        fluent.ListTile.selectable(
                          title: Text('Product Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 6,
                          onPressed: () {
                            context.go('/product/add');
                          },
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.product),
                    ),
                    ExpansionTile(
                      title: Text('Order'),
                      children: [
                        fluent.ListTile.selectable(
                          title: Text('Track Order'),
                          leading: Icon(fluent.FluentIcons.trackers),
                          selected: widget.selectedIndex == 6,
                        ),
                        fluent.ListTile.selectable(
                          title: Text('Order List'),
                          leading: Icon(fluent.FluentIcons.issue_tracking),
                          selected: widget.selectedIndex == 7,
                        ),
                        fluent.ListTile.selectable(
                          title: Text('Order Chart'),
                          leading: Icon(fluent.FluentIcons.chart),
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.clipboard_list),
                    ),
                    ExpansionTile(
                      title: Text('User'),
                      children: [
                        fluent.ListTile.selectable(
                          title: Text('User List'),
                          leading: Icon(fluent.FluentIcons.list),
                          selected: widget.selectedIndex == 12,
                          onPressed: () {
                            context.go('/user');
                          },
                        ),
                        fluent.ListTile.selectable(
                          title: Text('User Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 13,
                          onPressed: () {
                            context.go('/user/add');
                          },
                        ),
                      ],
                      leading: Icon(fluent.FluentIcons.account_management),
                    ),
                    ExpansionTile(
                      title: Text('Customer'),
                      children: [
                        fluent.ListTile.selectable(
                          title: Text('Customer List'),
                          leading: Icon(fluent.FluentIcons.list),
                          selected: widget.selectedIndex == 15,
                          onPressed: () {
                            context.go('/customer');
                          },
                        ),
                        fluent.ListTile.selectable(
                          title: Text('Customer Add'),
                          leading: Icon(fluent.FluentIcons.add),
                          selected: widget.selectedIndex == 16,
                          onPressed: () {
                            context.go('/customer/add');
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
                      },
                    ),
                    fluent.ListTile.selectable(
                      title: Text('Logout'),
                      leading: Icon(fluent.FluentIcons.sign_out),
                      selected: widget.selectedIndex == 15,
                      onPressed: () {
                        context.read<AuthProvider>().logout().then((value) => context.go('/login'));
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
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: widget.child,
    );
  }
}
