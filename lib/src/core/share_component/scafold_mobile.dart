import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';

class ScaffoldMobile extends fluent.StatefulWidget {
  final String title;
  final Widget child;
  const ScaffoldMobile({super.key, required this.title, required this.child});

  @override
  fluent.State<ScaffoldMobile> createState() => _ScaffoldMobileState();
}

class _ScaffoldMobileState extends fluent.State<ScaffoldMobile> {
  bool _isCategoryOpen = false;
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    fluent.ListTile.selectable(
                      title: fluent.Container(
                        alignment: Alignment.centerLeft,
                        height: 50.0,
                        child: fluent.Text('Home'),
                      ),
                      leading: fluent.Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Icon(fluent.FluentIcons.home),
                      ),
                      selected: true,
                    ),
                    fluent.ListTile.selectable(
                      title: fluent.Container(
                        alignment: Alignment.centerLeft,
                        height: 50.0,
                        child: fluent.Text('Category'),
                      ),
                      leading: Icon(fluent.FluentIcons.category_classification),
                      selected: true,
                      trailing: IconButton(
                        icon: Icon(
                          _isCategoryOpen
                              ? fluent.FluentIcons.chevron_down
                              : fluent.FluentIcons.chevron_up,
                          size: 12.0,
                        ),
                        onPressed: () {
                          setState(() {
                            _isCategoryOpen = !_isCategoryOpen;
                          });
                        },
                      ),
                    ),
                    fluent.Visibility(
                      visible: _isCategoryOpen,
                      child: fluent.Container(
                        child: Column(
                          children: [
                            fluent.ListTile(
                              title: Text('Category List'),
                              leading: Icon(fluent.FluentIcons.list),
                            ),
                            fluent.ListTile(
                              title: Text('Category Add'),
                              leading: Icon(fluent.FluentIcons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Setting'),
                      leading: Icon(fluent.FluentIcons.settings),
                    ),
                    ListTile(
                      title: Text('Logout'),
                      leading: Icon(fluent.FluentIcons.sign_out),
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
