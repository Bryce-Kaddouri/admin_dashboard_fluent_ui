import 'package:admin_dashboard/fluent_ui.dart';
import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:admin_dashboard/src/feature/home/presentation/screen/home_screen.dart';
import 'package:admin_dashboard/src/feature/home/presentation/screen/new_home_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../feature/auth/presentation/screen/signin_screen.dart';
import '../../feature/category/presentation/screen/update_category_screen.dart';
import '../../feature/product/presentation/screen/product_screen.dart';

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
  static back() {
    Get.key?.currentState?.pop();
  }

  GoRouter getRouter() {
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
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => TestFluentUI(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => /*HomeScreen(
            currentIndex: 0,
          ),*/
          NewHomeScreen(),
        ),
        GoRoute(
          path: '/category-list',
          builder: (context, state) => HomeScreen(
            currentIndex: 1,
          ),
        ),
        GoRoute(
          path: '/category-add',
          builder: (context, state) => HomeScreen(
            currentIndex: 2,
          ),
        ),
        GoRoute(
            path: '/category-update/:id',
            builder: (context, state) {
              String? id = state.pathParameters['id'];
              if (id == null) {
                return Scaffold(
                  body: Center(
                    child: Text('Category Not found'),
                  ),
                );
              } else {
                int idInt = int.parse(id);
                return UpdateCategoryScreen(
                  categoryId: idInt,
                );
              }
            }),
        GoRoute(
            path: '/product-update/:id',
            builder: (context, state) {
              String? id = state.pathParameters['id'];
              if (id == null) {
                return Scaffold(
                  body: Center(
                    child: Text('Product Not found'),
                  ),
                );
              } else {
                int idInt = int.parse(id);
                return UpdateProductScreen(
                  productId: idInt,
                );
              }
            }),
        GoRoute(
          path: '/product-list',
          builder: (context, state) => HomeScreen(
            currentIndex: 3,
          ),
        ),
        GoRoute(
          path: '/product-add',
          builder: (context, state) => HomeScreen(
            currentIndex: 4,
          ),
        ),
        GoRoute(
          path: '/order-list',
          builder: (context, state) => HomeScreen(
            currentIndex: 5,
          ),
        ),
        GoRoute(
          path: '/user-list',
          builder: (context, state) => HomeScreen(
            currentIndex: 6,
          ),
        ),
        GoRoute(
          path: '/user-add',
          builder: (context, state) => HomeScreen(
            currentIndex: 7,
          ),
        ),
        GoRoute(
            path: '/user-detail/:uid',
            builder: (context, state) {
              String? uid = state.pathParameters['uid'];
              if (uid == null) {
                return Scaffold(
                  body: Center(
                    child: Text('User Not found'),
                  ),
                );
              } else {
                return UserDetailScreen(
                  uid: uid,
                );
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
class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}

// class to create a navigator class that with a fonction that take the destination root and a bool to know if we want to slide on the left or on the right
class CustomNavigator {
  static Future<T?> push<T extends Object?>(
      BuildContext context, Widget destination,
      {bool replace = false}) {
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

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
      BuildContext context, Widget destination,
      {required String destinationRoute}) {
    return Navigator.pushAndRemoveUntil(
      context,
      CustomRoute(
        builder: (context) => destination,
      ),
      ModalRoute.withName(destinationRoute),
    );
  }

  static Future<T?> pushNamed<T extends Object?>(
      BuildContext context, String destination,
      {bool replace = false}) {
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

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      BuildContext context, String destination,
      {required String destinationRoute}) {
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
