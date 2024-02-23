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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child:
            PageView(
              children:[
                ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ListTile.selectable(
                        leading: SizedBox(
                          height: 100,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ColoredBox(
                              color: Colors.accentColors[index ~/ 20],
                              child: const Placeholder(),
                            ),
                          ),
                        ),
                        title: Text('Contact ${index + 1}'),
                        subtitle: const Text('With a custom subtitle'),
                        selectionMode: ListTileSelectionMode.single,
                        selected: false,
/*
                        onSelectionChange: (v) => setState(() => selectedContact = contact),
*/
                      );
                    }
                ),
                ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ListTile.selectable(
                        leading: SizedBox(
                          height: 100,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ColoredBox(
                              color: Colors.accentColors[index ~/ 20],
                              child: const Placeholder(),
                            ),
                          ),
                        ),
                        title: Text('Contact ${index + 1}'),
                        subtitle: const Text('With a custom subtitle'),
                        selectionMode: ListTileSelectionMode.single,
                        selected: false,
/*
                        onSelectionChange: (v) => setState(() => selectedContact = contact),
*/
                      );
                    }
                ),
              ],
            ),
            ),
            Container(
              height: 50,
              color: Colors.blue,
              child: const Center(child: Text('Footer')),
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return NavigationView(

     /* appBar: NavigationAppBar(
        leading: Container(
          child: IconButton(
            icon: Icon(displayMode == PaneDisplayMode.open
                ? FluentIcons.back
                : FluentIcons.forward),
            onPressed: () {
              setState(() {
                displayMode = displayMode == PaneDisplayMode.open
                    ? PaneDisplayMode.compact
                    : PaneDisplayMode.open;
              });
            },
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: displayMode ==  PaneDisplayMode.open ? 255 : 0),
            Expanded(child:
            AnimatedContainer(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 300),
              child: TextBox(
                prefixMode: OverlayVisibilityMode.always,

                prefix: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: const Icon(
                    FluentIcons.search,
                    size: 20,
                    color: Colors.black,
                  )
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey),
                ),
              ),
            ),
            ),
            // select between 10, 25, 50, 100 and 250
            DropDownButton(
              title: Text('10'),
              items: [
                MenuFlyoutItem(text: const Text('10'), onPressed: () {}),
                MenuFlyoutSeparator(),
                MenuFlyoutItem(text: const Text('25'), onPressed: () {}),
                MenuFlyoutSeparator(),
                MenuFlyoutItem(text: const Text('50'), onPressed: () {}),
                MenuFlyoutSeparator(),
                MenuFlyoutItem(text: const Text('100'), onPressed: () {}),
                MenuFlyoutSeparator(),
                MenuFlyoutItem(text: const Text('250'), onPressed: () {}),
              ],
            ),
            SizedBox(width: 10),
            FilledButton(
              style: ButtonStyle(
                shape: ButtonState.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),
                padding: ButtonState.all(const EdgeInsets.all(8.0)),
                backgroundColor: ButtonState.all(Colors.blue),
                foregroundColor: ButtonState.all(Colors.white),
              ),
              onPressed: () {
                // Your Logic to Add New `NavigationPaneItem`
                print('Search');
              }, child:
             const Icon(FluentIcons.add),
            ),
          ],
        ),
      ),*/

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

