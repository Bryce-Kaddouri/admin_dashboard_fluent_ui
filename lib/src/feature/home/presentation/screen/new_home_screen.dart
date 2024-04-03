import 'package:admin_dashboard/src/feature/category/presentation/screen/category_add_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_list_screen.dart';
import 'package:admin_dashboard/src/feature/customer/presentation/screen/customer_add_screen.dart';
import 'package:admin_dashboard/src/feature/customer/presentation/screen/customer_list_screen.dart';
import 'package:admin_dashboard/src/feature/order/presentation/screen/order_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/product_add_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/product_list_screen.dart';
import 'package:admin_dashboard/src/feature/setting/presentation/screen/setting_screen.dart';
import 'package:admin_dashboard/src/feature/stat/presentation/screen/stat_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_add_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_list_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/provider/auth_provider.dart';

class NewHomeScreen extends StatefulWidget {
  Widget child;
  int index;

  NewHomeScreen({Key? key, required this.child, required this.index}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

// keep alive
class _NewHomeScreenState extends State<NewHomeScreen> with AutomaticKeepAliveClientMixin {
  PaneDisplayMode displayMode = PaneDisplayMode.open;

  String getTitleScreen(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Category';
      case 2:
        return 'Category List';
      case 3:
        return 'Add Category';
      case 4:
        return 'Product';
      case 5:
        return 'Product List';
      case 6:
        return 'Add Product';
      case 7:
        return 'Order';
      case 8:
        return 'Track orders';
      case 9:
        return 'Order List';
      case 10:
        return 'Chart Orders';
      case 11:
        return 'User';
      case 12:
        return 'User List';
      case 13:
        return 'Add User';
      case 14:
        return 'Catalog';
      case 15:
        return 'Customer List';
      case 16:
        return 'Add Customer';
      case 17:
        return 'Settings';
      default:
        return 'Home';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerRight,
          child: Container(
            width: displayMode == PaneDisplayMode.open ? MediaQuery.of(context).size.width - 340 : MediaQuery.of(context).size.width - 60,
            alignment: Alignment.center,
            child: Text(
              getTitleScreen(widget.index),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      pane: NavigationPane(
        selected: widget.index,
        onChanged: (index) {
          if (index != 1 && index != 4 && index != 7 && index != 11 && index != 14) {
            print('index: $index');
          }
        },
        displayMode: displayMode,
        items: [
          PaneItem(
            onTap: () {
              context.go('/');
            },
            icon: const Icon(FluentIcons.home),
            title: const Text('Home', overflow: TextOverflow.ellipsis),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Welcome to the Home Page',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          PaneItemSeparator(),
          PaneItemExpander(
            icon: const Icon(FluentIcons.category_classification),
            title: const Text('Category', overflow: TextOverflow.ellipsis),
            body: Container(),
            items: [
              PaneItem(
                onTap: () {
                  context.go('/category');
                },
                icon: const Icon(FluentIcons.list),
                title: const Text('Category List', overflow: TextOverflow.ellipsis),
                body: CategoryListScreen(),
              ),
              PaneItem(
                onTap: () {
                  context.go('/category/add');
                },
                icon: const Icon(FluentIcons.add),
                title: const Text('Add Category', overflow: TextOverflow.ellipsis),
                body: CategoryAddScreen(),
              ),
            ],
          ),
          PaneItemExpander(
            icon: const Icon(FluentIcons.product),
            title: const Text('Product', overflow: TextOverflow.ellipsis),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Manage your prod here',
                style: TextStyle(fontSize: 20),
              ),
            ),
            items: [
              PaneItem(
                onTap: () {
                  context.go('/product');
                },
                icon: const Icon(FluentIcons.list),
                title: const Text('Product List', overflow: TextOverflow.ellipsis),
                body: ProductListScreen(),
              ),
              PaneItem(
                onTap: () {
                  context.go('/product/add');
                },
                icon: const Icon(FluentIcons.add),
                title: const Text('Add Product', overflow: TextOverflow.ellipsis),
                body: ProductAddScreen(),
              ),
            ],
          ),
          PaneItemExpander(
            icon: const Icon(FluentIcons.category_classification),
            title: const Text('Order', overflow: TextOverflow.ellipsis),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Manage your categ here',
                style: TextStyle(fontSize: 20),
              ),
            ),
            items: [
              PaneItem(
                onTap: () {
                  context.go('/track-orders');
                },
                icon: const Icon(FluentIcons.trackers),
                title: const Text('Track orders', overflow: TextOverflow.ellipsis),
                infoBadge: const InfoBadge(source: Text('8')),
                body: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Track your orders here',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              PaneItem(
                onTap: () {
                  context.go('/orders');
                },
                icon: const Icon(FluentIcons.issue_tracking),
                title: const Text('Order List', overflow: TextOverflow.ellipsis),
                body: OrderScreen(),
              ),
              PaneItem(
                onTap: () {
                  context.go('/orders/chart');
                },
                icon: const Icon(FluentIcons.chart),
                title: const Text('Chart', overflow: TextOverflow.ellipsis),
                body: StatScreen(),
              ),
            ],
          ),
          PaneItemExpander(
            icon: const Icon(FluentIcons.account_management),
            title: const Text('User', overflow: TextOverflow.ellipsis),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Manage your user here',
                style: TextStyle(fontSize: 20),
              ),
            ),
            items: [
              PaneItem(
                  onTap: () {
                    context.go('/user');
                  },
                  icon: const Icon(FluentIcons.list),
                  title: const Text('user List', overflow: TextOverflow.ellipsis),
                  body: UserListScreen()),
              PaneItem(
                onTap: () {
                  context.go('/user/add');
                },
                icon: const Icon(FluentIcons.add),
                title: const Text('Add User', overflow: TextOverflow.ellipsis),
                body: UserAddScreen(),
              ),
            ],
          ),
          PaneItemExpander(
            icon: const Icon(FluentIcons.hexadite_investigation_semi_auto),
            title: const Text('Customer', overflow: TextOverflow.ellipsis),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Manage your user here',
                style: TextStyle(fontSize: 20),
              ),
            ),
            items: [
              PaneItem(
                  onTap: () {
                    context.go('/customer');
                  },
                  icon: const Icon(FluentIcons.list),
                  title: const Text('Customer List', overflow: TextOverflow.ellipsis),
                  body: CustomerListScreen()),
              PaneItem(
                onTap: () {
                  context.go('/customer/add');
                },
                icon: const Icon(FluentIcons.add),
                title: const Text('Customer User', overflow: TextOverflow.ellipsis),
                body: CustomerAddScreen(),
              ),
            ],
          ),
          PaneItemExpander(
            icon: const Icon(FluentIcons.book_answers),
            title: const Text('Catalog', overflow: TextOverflow.ellipsis),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Manage your catalog here',
                style: TextStyle(fontSize: 20),
              ),
            ),
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.list),
                title: const Text('Page List', overflow: TextOverflow.ellipsis),
                body: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Manage your category here',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.add),
                title: const Text('Add Page', overflow: TextOverflow.ellipsis),
                body: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Check your add here',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
        header: Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Admin DashBoard',
            style: TextStyle(fontSize: 20),
          ),
        ),
        menuButton: Container(
          margin: const EdgeInsets.all(5),
          height: 40,
          width: 50,
          child: IconButton(
            icon: Icon(FluentIcons.collapse_menu, size: 20),
            onPressed: () {
              setState(() {
                displayMode = displayMode == PaneDisplayMode.open ? PaneDisplayMode.compact : PaneDisplayMode.open;
              });
            },
          ),
        ),
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: Text('Setting', overflow: TextOverflow.ellipsis),
            body: SettingScreen(),
            onTap: () {
              context.go('/setting');
            },
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.sign_out),
            title: Text('Logout', overflow: TextOverflow.ellipsis),
            onTap: () async {
              // Your Logic to Add New `NavigationPaneItem`

              bool? result = await showDialog<bool>(
                context: context,
                builder: (context) => ContentDialog(
                  title: Container(
                    alignment: Alignment.center,
                    child: Text('Logout', style: TextStyle(fontSize: 20)),
                  ),
                  content: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(FluentIcons.sign_out, size: 50, color: Colors.red),
                        SizedBox(height: 20),
                        Text('Are you sure you want to logout?'),
                      ],
                    ),
                  ),
                  actions: [
                    Button(
                      child: const Text('Logout'),
                      onPressed: () {
                        Navigator.pop(context, true);
                        // Delete file here
                      },
                      style: ButtonStyle(
                        padding: ButtonState.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    FilledButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context, false),
                      style: ButtonStyle(
                        padding: ButtonState.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              if (result != null && result) {
                context.read<AuthProvider>().logout();
                context.go('/login');
              }
              print('Logout');
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
