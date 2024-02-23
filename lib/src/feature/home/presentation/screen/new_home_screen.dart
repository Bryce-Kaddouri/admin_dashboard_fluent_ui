import 'package:admin_dashboard/src/feature/category/presentation/screen/category_add_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_list_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';

class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SideNavBar();

  }
}

class SideNavBar extends StatefulWidget {
  SideNavBar({super.key});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  int topIndex = 0;
  PaneDisplayMode displayMode = PaneDisplayMode.open;

  List<NavigationPaneItem> items = [
   PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home',overflow: TextOverflow.ellipsis),
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
      title: const Text('Category',overflow: TextOverflow.ellipsis),
      body: Container(
      ),
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.list),
          title: const Text('Category List',overflow: TextOverflow.ellipsis),
          body: CategoryListScreen(
            mainPageController: PageController(),
          ),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.add),
          title: const Text('Add Category',overflow: TextOverflow.ellipsis),
          body: CategoryAddScreen(),
        ),
      ],
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.product),
      title: const Text('Product',overflow: TextOverflow.ellipsis),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Manage your prod here',
          style: TextStyle(fontSize: 20),
        ),
      ),
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.list),
          title: const Text('Product List',overflow: TextOverflow.ellipsis),
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
          title: const Text('Add Product',overflow: TextOverflow.ellipsis),
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
    PaneItemExpander(
      icon: const Icon(FluentIcons.category_classification),
      title: const Text('Order',overflow: TextOverflow.ellipsis),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Manage your categ here',
          style: TextStyle(fontSize: 20),
        ),
      ),
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.trackers),
          title: const Text('Track orders',overflow: TextOverflow.ellipsis),
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
          icon: const Icon(FluentIcons.issue_tracking),
          title: const Text('Order List',overflow: TextOverflow.ellipsis),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Manage your category here',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.chart),
          title: const Text('Chart',overflow: TextOverflow.ellipsis),
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
    PaneItemExpander(
      icon: const Icon(FluentIcons.account_management),
      title: const Text('User',overflow: TextOverflow.ellipsis),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Manage your user here',
          style: TextStyle(fontSize: 20),
        ),
      ),
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.list),
          title: const Text('user List',overflow: TextOverflow.ellipsis),
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
          title: const Text('Add User',overflow: TextOverflow.ellipsis),
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
    PaneItemExpander(
      icon: const Icon(FluentIcons.book_answers),
      title: const Text('Catalog',overflow: TextOverflow.ellipsis),
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
          title: const Text('Page List',overflow: TextOverflow.ellipsis),
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
          title: const Text('Add Page',overflow: TextOverflow.ellipsis),
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
    PaneItem(
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings',overflow: TextOverflow.ellipsis),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Change your settings here',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),



  ];

  String getTitleScreen(int index){
    switch(index) {
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
        return 'Chart';
      case 11:
        return 'User';
      case 12:
        return 'User List';
      case 13:
        return 'Add User';
      case 14:
        return 'Catalog';
      case 15:
        return 'Page List';
      case 16:
        return 'Add Page';
      case 17:
        return 'Settings';
      default:
        return 'Home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(

      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerRight,
          child: Container(
            width: displayMode == PaneDisplayMode.open ? MediaQuery.of(context).size.width - 340 : MediaQuery.of(context).size.width - 60,

            alignment: Alignment.center,
            child:  Text(
              getTitleScreen(topIndex),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),

      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => {
          if(index != 1 && index != 4 && index != 7 && index != 11 && index != 14)
            setState(() => topIndex = index),
        },
        displayMode: displayMode,
        items: items,
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
                displayMode = displayMode == PaneDisplayMode.open
                    ? PaneDisplayMode.compact
                    : PaneDisplayMode.open;
              });
            },
          ),
        ),
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: Text('Setting', overflow: TextOverflow.ellipsis),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Change your settings here',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.sign_out),
            title: Text('Logout', overflow: TextOverflow.ellipsis),
            onTap: () {
              // Your Logic to Add New `NavigationPaneItem`
              print('Logout');
            },
          ),
        ],
      ),
    );
  }
}

