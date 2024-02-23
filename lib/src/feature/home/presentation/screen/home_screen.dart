import 'package:admin_dashboard/src/feature/category/presentation/screen/category_add_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_list_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/product_add_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/product_list_screen.dart';
import 'package:admin_dashboard/src/feature/stat/presentation/screen/stat_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_add_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/share_component/custom_side_bar.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  int currentIndex;

  HomeScreen({super.key, required this.currentIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  /* bool isCollapsed = true;*/

  late PageController pageController;

  int idCategory = -1;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.currentIndex);
    print('isCollapsed: ${context.read<HomeProvider>().isCollapsed}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            SideBarCustomWidget(
              selectedIndex: widget.currentIndex,
            ),
            Expanded(
                child: Container(
                    child: PageView(
              controller: pageController,
              children: [
                StatScreen(),
                CategoryListScreen(mainPageController: pageController),
                CategoryAddScreen(pageController: pageController),
                ProductListScreen(mainPageController: pageController),
                ProductAddScreen(pageController: pageController),
                Container(
                  child: Center(
                    child: Text('Orders'),
                  ),
                ),
                UserListScreen(mainPageController: pageController),
                UserAddScreen(pageController: pageController),
                Container(
                  child: Center(
                    child: Text('Page List'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('Add Page'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('Settings'),
                  ),
                ),
              ],
            )))
          ],
        ),
      ),
      /*SideBarWidget(
        pageController: pageController,
        selectedIndex: 0,
        body: Container(
          child: PageView(
            allowImplicitScrolling: false,
            controller: pageController,
            children: [
              Container(
                child: Center(
                  child: Text('Home'),
                ),
              ),
              CategoryScreen(),
              CategoryListScreen(
                mainPageController: pageController,
              ),
              CategoryAddScreen(pageController: pageController),
              CategoryAddScreen(pageController: pageController),
              ProductScreen(),
              ProductListScreen(
                mainPageController: pageController,
              ),
              ProductAddScreen(pageController: pageController),
              ProductAddScreen(pageController: pageController),
              Container(
                child: Center(
                  child: Text('Employees'),
                ),
              ),
              UserListScreen(mainPageController: pageController),
              UserAddScreen(pageController: pageController),
              Container(
                child: Center(
                  child: Text('Settings'),
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}

/*List lstPages = [
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
];*/
