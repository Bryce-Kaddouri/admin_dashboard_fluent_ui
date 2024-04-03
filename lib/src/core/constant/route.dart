import 'package:admin_dashboard/src/core/share_component/scafold_mobile.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_add_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_list_screen.dart';
import 'package:admin_dashboard/src/feature/customer/presentation/screen/customer_add_screen.dart';
import 'package:admin_dashboard/src/feature/customer/presentation/screen/customer_list_screen.dart';
import 'package:admin_dashboard/src/feature/customer/presentation/screen/update_customer_screen.dart';
import 'package:admin_dashboard/src/feature/home/presentation/screen/new_home_screen.dart';
import 'package:admin_dashboard/src/feature/order/presentation/screen/order_detail_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/product_add_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/product_list_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/update_product_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_add_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_list_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../feature/auth/presentation/provider/auth_provider.dart';
import '../../feature/auth/presentation/screen/signin_screen.dart';
import '../../feature/category/presentation/screen/update_category_screen.dart';
import '../../feature/order/presentation/screen/order_screen.dart';
import '../../feature/setting/presentation/screen/setting_screen.dart';
import '../../feature/user/presentation/screen/user_update_screen.dart';
import '../helper/responsive_helper.dart';

/*class Routes {
  static const String home = '/home';
  static const String login = '/login';

  final getPages = [
    GetPage(
      participatesInRootNavigator: true,
      name: Routes.home,
      page: () => HomeScreen(),
      transition: Transition.zoom,
      children: [],
    ),
    GetPage(
      participatesInRootNavigator: true,
      name: Routes.login,
      page: () => SignInScreen(),
      transition: Transition.zoom,
      children: [],
    ),
  ];
}*/

class RouterHelper {
  GoRouter getRouter(BuildContext context) {
    return GoRouter(
      navigatorKey: Get.key,
      redirect: (context, state) {
        // check if user is logged in
        // if not, redirect to login page

        print('state: ${state.matchedLocation}');
        print('state: ${state.uri}');

        bool isLoggedIn = context.read<AuthProvider>().checkIsLoggedIn();
        print('isLoggedIn: $isLoggedIn');

        if (!isLoggedIn && state.uri.path != '/login') {
          return '/login';
        } else {
          return state.uri.path;
        }
      },
      initialLocation: context.read<AuthProvider>().checkIsLoggedIn() ? '/' : '/login',
      routes: [
        /*GoRoute(
          path: '/orders',
          builder: (context, state) {
            return const OrderScreen();
          },
          routes: [
            GoRoute(
              path: ':date/:id',
              builder: (context, state) {
                print(state.pathParameters);
                if (state.pathParameters.isEmpty || state.pathParameters['id'] == null || state.pathParameters['date'] == null) {
                  return ScaffoldPage(
                      content: Center(
                    child: Text('Loading...'),
                  ));
                } else {
                  int orderId = int.parse(state.pathParameters['id']!);
                  DateTime orderDate = DateTime.parse(state.pathParameters['date']!);
                  return OrderDetailScreen(orderId: orderId, orderDate: orderDate);
                }
              },
            ),
          ],
        ),*/
        ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) {
              print('state: ${state.path}');
              print('state: ${state.matchedLocation}');

              int index = 0;
              String title = '';
              if (state.matchedLocation == '/') {
                index = 1;
                title = 'Home';
              } else if (state.matchedLocation == '/category') {
                index = 2;
                title = 'Category';
              } else if (state.matchedLocation == '/category/add') {
                index = 3;
                title = 'Add Category';
              } else if (state.matchedLocation == '/product') {
                index = 5;
                title = 'Product';
              } else if (state.matchedLocation == '/product/add') {
                index = 6;
                title = 'Add Product';
              } else if (state.matchedLocation == '/orders') {
                index = 9;
                title = 'Orders';
              } else if (state.matchedLocation == '/orders/chart') {
                index = 10;
                title = 'Orders Chart';
              } else if (state.matchedLocation == '/user') {
                index = 12;
                title = 'User';
              } else if (state.matchedLocation == '/user/add') {
                index = 13;
                title = 'Add User';
              } else if (state.matchedLocation == '/customer') {
                index = 15;
                title = 'Customer';
              } else if (state.matchedLocation == '/customer/add') {
                index = 16;
                title = 'Add Customer';
              } else if (state.matchedLocation == '/setting') {
                index = 20;
                title = 'Setting';
              }

              if (!ResponsiveHelper.isMobile(context)) {
                return NewHomeScreen(index: index, child: child);
              } else {
                return ScaffoldMobile(
                  title: title,
                  selectedIndex: index,
                  child: child,
                );
              }
            },
            routes: [
              GoRoute(
                  path: '/',
                  builder: (context, state) {
                    return Container(
                      child: Text('Home'),
                    );
                  }),
              GoRoute(
                  path: '/category',
                  builder: (context, state) {
                    return CategoryListScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'add',
                        builder: (state, context) {
                          return CategoryAddScreen();
                        }),
                  ]),
              GoRoute(
                  path: '/product',
                  builder: (context, state) {
                    return ProductListScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'add',
                        builder: (state, context) {
                          return ProductAddScreen();
                        }),
                  ]),
              GoRoute(
                path: '/orders',
                builder: (context, state) {
                  return OrderScreen();
                },
                routes: [
                  GoRoute(
                    path: 'chart',
                    builder: (context, state) {
                      return Container();
                    },
                  ),
                ],
              ),
              GoRoute(
                  path: '/user',
                  builder: (context, state) {
                    return UserListScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'add',
                        builder: (state, context) {
                          return UserAddScreen();
                        }),
                  ]),
              GoRoute(
                  path: '/customer',
                  builder: (context, state) {
                    return CustomerListScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'add',
                        builder: (state, context) {
                          return CustomerAddScreen();
                        }),
                  ]),
              GoRoute(
                path: '/setting',
                builder: (context, state) => SettingScreen(),
              ),
            ]),
        GoRoute(
            path: '/category/update/:id',
            builder: (context, state) {
              String? id = state.pathParameters['id'];
              if (id == null) {
                return ScaffoldPage(
                  content: Center(
                    child: Text('Product Not found'),
                  ),
                );
              } else {
                int idInt = int.parse(id);
                return UpdateCategoryScreen(categoryId: idInt);
              }
            }),
        GoRoute(
            path: '/product/update/:id',
            builder: (context, state) {
              String? id = state.pathParameters['id'];
              if (id == null) {
                return ScaffoldPage(
                  content: Center(
                    child: Text('Product Not found'),
                  ),
                );
              } else {
                int idInt = int.parse(id);
                return UpdateProductScreen(productId: idInt);
              }
            }),
        GoRoute(
          path: '/orders/:date/:id',
          builder: (context, state) {
            print(state.pathParameters);
            if (state.pathParameters.isEmpty || state.pathParameters['id'] == null || state.pathParameters['date'] == null) {
              return ScaffoldPage(
                  content: Center(
                child: Text('Loading...'),
              ));
            } else {
              int orderId = int.parse(state.pathParameters['id']!);
              DateTime orderDate = DateTime.parse(state.pathParameters['date']!);
              return OrderDetailScreen(orderId: orderId, orderDate: orderDate);
            }
          },
        ),
        GoRoute(
            path: '/user/update/:id',
            builder: (context, state) {
              String? id = state.pathParameters['id'];
              if (id == null) {
                return ScaffoldPage(
                  content: Center(
                    child: Text('Product Not found'),
                  ),
                );
              } else {
                return UserUpdateScreen(uid: id);
              }
            }),
        GoRoute(
            path: '/customer/update/:id',
            builder: (context, state) {
              String? idString = state.pathParameters['id'];
              if (idString == null) {
                return ScaffoldPage(
                  content: Center(
                    child: Text('Customer Not found'),
                  ),
                );
              } else {
                int id = int.parse(idString);
                return UpdateCustomerScreen(customerId: id);
              }
            }),
        GoRoute(
          path: '/login',
          builder: (context, state) => SignInScreen(),
        ),
      ],
    );
  }
}

// custome route class to custom transition
class CustomRoute<T> extends material.MaterialPageRoute<T> {
  CustomRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}

// class to create a navigator class that with a fonction that take the destination root and a bool to know if we want to slide on the left or on the right
class CustomNavigator {
  static Future<T?> push<T extends Object?>(BuildContext context, Widget destination, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacement(
        context,
        CustomRoute(
          builder: (context) => destination,
        ),
      );
    } else {
      return Navigator.push(
        context,
        CustomRoute(
          builder: (context) => destination,
        ),
      );
    }
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(BuildContext context, Widget destination, {required String destinationRoute}) {
    return Navigator.pushAndRemoveUntil(
      context,
      CustomRoute(
        builder: (context) => destination,
      ),
      ModalRoute.withName(destinationRoute),
    );
  }

  static Future<T?> pushNamed<T extends Object?>(BuildContext context, String destination, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacementNamed(
        context,
        destination,
      );
    } else {
      return Navigator.pushNamed(
        context,
        destination,
      );
    }
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(BuildContext context, String destination, {required String destinationRoute}) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      destination,
      ModalRoute.withName(destinationRoute),
    );
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  static void popUntil(BuildContext context, String destinationRoute) {
    Navigator.popUntil(context, ModalRoute.withName(destinationRoute));
  }
}
