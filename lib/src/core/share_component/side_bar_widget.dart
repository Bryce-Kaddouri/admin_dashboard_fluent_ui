import 'package:admin_dashboard/src/feature/product/presentation/provider/product_provider.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class SideBarWidget extends StatefulWidget {
  final int selectedIndex;
  final Widget body;
  final PageController pageController;

  SideBarWidget(
      {required this.selectedIndex,
      required this.body,
      required this.pageController});

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  bool isCollapsed = false;
  List lstPages = [
    {
      'name': 'Home',
      'index': 0,
      'children': [],
      'icon': const Icon(Icons.home),
      'onTap': () => print('Home'),
      'isVisibled': true,
    },
    {
      'name': 'Categories',
      'index': 1,
      'children': [
        {
          'name': 'Category List',
          'index': 2,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10),
          'onTap': () => print('Category List'),
          'isVisibled': true,
        },
        {
          'name': 'Add Category',
          'index': 3,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10),
          'onTap': () => print('Add Category'),
          'isVisibled': true,
        },
        {
          'name': 'Update Category',
          'index': 4,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10),
          'onTap': () => print('Add Category'),
          'isVisibled': false,
        }
      ],
      'icon': const Icon(Icons.category),
      'onTap': () => print('Categories'),
      'isVisibled': true,
    },
    {
      'name': 'Products',
      'index': 5,
      'children': [
        {
          'name': 'Product List',
          'index': 6,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10),
          'onTap': () => print('Product List'),
          'isVisibled': true,
        },
        {
          'name': 'Add Product',
          'index': 7,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10),
          'onTap': () =>
              Get.context!.read<ProductProvider>().setProductModel(null),
          'isVisibled': true,
        },
      ],
      'icon': const Icon(Icons.cake_rounded),
      'onTap': () => print('Products'),
      'isVisibled': true,
    },
    {
      'name': 'Users',
      'index': 9,
      'children': [
        {
          'name': 'User List',
          'index': 10,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10),
          'onTap': () => print('User List'),
          'isVisibled': true,
        },
        {
          'name': 'Add User',
          'index': 11,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10),
          'onTap': () => print('Add User'),
          'isVisibled': true,
        },
      ],
      'icon': const Icon(Icons.group),
      'onTap': () => print('Users'),
      'isVisibled': true,
    },
    {
      'name': 'Settings',
      'index': 11,
      'children': [],
      'icon': const Icon(Icons.settings),
      'onTap': () => print('Settings'),
      'isVisibled': true,
    },
    {
      'name': 'Logout',
      'index': 12,
      'children': [],
      'icon': const Icon(Icons.logout),
      'onTap': () => print('Logout'),
      'isVisibled': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CollapsibleSidebar(
      onTapToggled: () {
        setState(() {
          isCollapsed = !isCollapsed;
        });
      },
      collapseOnBodyTap: false,
      isCollapsed: isCollapsed,
      items: List.generate(lstPages.length, (index) {
        return CollapsibleItem(
          text: lstPages[index]['name'],
          icon: lstPages[index]['icon'],
          onPressed: () =>
              widget.pageController.jumpToPage(lstPages[index]['index']),
          isSelected: widget.selectedIndex == lstPages[index]['index'],
          subItems: lstPages[index]['children'].isEmpty
              ? null
              : List.generate(
                  lstPages[index]['children']
                      .where((element) => element['isVisibled'] == true)
                      .length, (i) {
                  return CollapsibleItem(
                    text: lstPages[index]['children'][i]['name'],
                    icon: lstPages[index]['children'][i]['icon'],
                    onPressed: () {
                      lstPages[index]['children'][i]['onTap']();
                      widget.pageController
                          .jumpToPage(lstPages[index]['children'][i]['index']);
                    },
                    isSelected: widget.selectedIndex ==
                        lstPages[index]['children'][i]['index'],
                  );
                }),
        );
      }),
      minWidth: 80,
      maxWidth: 250,
      avatarImg:
          NetworkImage("https://cdn-icons-png.flaticon.com/512/330/330703.png"),
      title: 'John Smith',
      onTitleTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Yay! Flutter Collapsible Sidebar!')));
      },
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
          width: isCollapsed
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width - 270,
          height: MediaQuery.of(context).size.height,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 500),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.black,
          ),
          child: widget.body,
        ),
      ),
      backgroundColor: Colors.black,
      selectedTextColor: Colors.limeAccent,
      textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
      titleStyle: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
      toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      sidebarBoxShadow: [],
      /* sidebarBoxShadow: [
        BoxShadow(
          color: Colors.indigo,
          blurRadius: 20,
          spreadRadius: 0.01,
          offset: Offset(3, 3),
        ),
        BoxShadow(
          color: Colors.green,
          blurRadius: 50,
          spreadRadius: 0.01,
          offset: Offset(3, 3),
        ),
      ],*/
    );
  }
}
