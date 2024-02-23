import 'package:fluent_ui/fluent_ui.dart';

class TestFluentUI extends StatefulWidget {
  TestFluentUI({super.key});

  @override
  State<TestFluentUI> createState() => _TestFluentUIState();
}

class _TestFluentUIState extends State<TestFluentUI> {
  int topIndex = 0;

  List<NavigationPaneItem> items = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const Center(
        child: Text('Welcome to the Home Page'),
      ),
    ),
    PaneItemSeparator(),
    PaneItem(
      icon: const Icon(FluentIcons.issue_tracking),
      title: const Text('Track orders'),
      infoBadge: const InfoBadge(source: Text('8')),
      body: Center(
        child: Text('This is the body of the item'),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.disable_updates),
      title: const Text('Disabled Item'),
      body: const Center(
        child: Text('This is the body of the item'),
      ),
      enabled: false,
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.account_management),
      title: const Text('Account'),
      body: const Center(
        child: Text('This is the body of the item'),
      ),
      items: [
        PaneItemHeader(header: const Text('Apps')),
        PaneItem(
          icon: const Icon(FluentIcons.mail),
          title: const Text('Mail'),
          body: const Center(
            child: Text('This is the body of the item'),
          ),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.calendar),
          title: const Text('Calendar'),
          body: const Center(
            child: Text('This is the body of the item'),
          ),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('NavigationView'),
      ),
      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: PaneDisplayMode.compact,
        items: items,
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const Center(
              child: Text('This is the body of the item'),
            ),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.add),
            title: const Text('Add New Item'),
            onTap: () {
              // Your Logic to Add New `NavigationPaneItem`
              items.add(
                PaneItem(
                  icon: const Icon(FluentIcons.new_folder),
                  title: const Text('New Item'),
                  body: const Center(
                    child: Text(
                      'This is a newly added Item',
                    ),
                  ),
                ),
              );
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
