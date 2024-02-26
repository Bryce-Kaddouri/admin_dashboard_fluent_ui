import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../provider/user_provider.dart';

class UserListScreen extends StatefulWidget {
  UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  /* PageController pageController = PageController(
    initialPage: 0,
  );
  int nbPages = 0;
*/

  int currentPage = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    print(pageController.hasListeners);
    pageController.addListener(() {
      print('pageController.page: ${pageController.page}');
      setState(() {
        currentPage = pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /* Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.blue,
              width: 4,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              */ /*Expanded(
                child: FormBuilderTextField(
                  name: 'sarch',
                  controller: context.watch<UserProvider>().searchController,
                  onChanged: (value) {
                    print('value: $value');
                    context.read<UserProvider>().setSearchText(value!);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: InkWell(
                      child: Icon(Icons.clear),
                      onTap: () {
                        context.read<UserProvider>().setSearchText('');
                        context.read<UserProvider>().setTextController('');
                      },
                    ),
                    contentPadding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxHeight: 40,
                    ),
                    hintText: 'Search a user ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),*/ /*
              SizedBox(width: 10),
              */ /*   Expanded(
                child: Container(
                  height: 40,
                  child: FormBuilderCheckboxGroup(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    name: 'role',
                    initialValue: ['ADMIN', 'COOKER', 'SELLER', 'BOOK'],
                    options: List.generate(
                            4,
                            (index) =>
                                ['ADMIN', 'COOKER', 'SELLER', 'BOOK'][index])
                        .map((e) => FormBuilderFieldOption(value: e))
                        .toList(),
                    onChanged: (value) {
                      print('value: $value');
                      context.read<UserProvider>().setRoles(value!);

*/ /* */ /*
                context.read<UserProvider>().setSearchText(value!);
*/ /* */ /*
                    },
                  ),
                ),
              ),*/ /*
              */ /* Container(
                width: 80,
                height: 40,
                child: FormBuilderDropdown(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      print('value: $value');
                      context.read<UserProvider>().setNbItemPerPage(value!);
                    },
                    initialValue: context.watch<UserProvider>().nbItemPerPage,
                    name: 'item_per_page',
                    items: [
                      DropdownMenuItem(
                        child: Text('10'),
                        value: 10,
                      ),
                      DropdownMenuItem(
                        child: Text('25'),
                        value: 25,
                      ),
                      DropdownMenuItem(
                        child: Text('50'),
                        value: 50,
                      ),
                    ]),
              ),*/ /*
              SizedBox(width: 10),
              */ /*  Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent,
                ),
                child: InkWell(
                  child: Icon(Icons.add, color: Colors.white),
                  onTap: () {
                    print('add');
                    context.read<UserProvider>().setSelectedUser(null);

                  },
                ),
              ),*/ /*
            ],
          ),
        ),*/
        Card(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: AnimatedContainer(
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
                        )),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Text('ADMIN'),
                        SizedBox(width: 5),
                        Checkbox(
                          onChanged: (value) {
                            context
                                .read<UserProvider>()
                                .setAdminIsChecked(value!);
                          },
                          checked: context.watch<UserProvider>().adminIsChecked,
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Text('COOKER'),
                        SizedBox(width: 5),
                        Checkbox(
                          onChanged: (value) {
                            context
                                .read<UserProvider>()
                                .setCookerIsChecked(value!);
                          },
                          checked:
                              context.watch<UserProvider>().cookerIsChecked,
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Text('SELLER'),
                        SizedBox(width: 5),
                        Checkbox(
                          onChanged: (value) {
                            context
                                .read<UserProvider>()
                                .setSellerIsChecked(value!);
                          },
                          checked:
                              context.watch<UserProvider>().sellerIsChecked,
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Text('BOOK'),
                        SizedBox(width: 5),
                        Checkbox(
                          onChanged: (value) {
                            context
                                .read<UserProvider>()
                                .setBookIsChecked(value!);
                          },
                          checked: context.watch<UserProvider>().bookIsChecked,
                        ),
                      ]),
                    )
                  ],
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
                  shape: ButtonState.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  padding: ButtonState.all(const EdgeInsets.all(8.0)),
                  backgroundColor: ButtonState.all(Colors.blue),
                  foregroundColor: ButtonState.all(Colors.white),
                ),
                onPressed: () {
                  // Your Logic to Add New `NavigationPaneItem`
                  print('Search');
                },
                child: const Icon(FluentIcons.add),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<User>>(
            future: context.read<UserProvider>().getUsers(),
            builder: (context, snapshot) {
              print('snapshot: ${snapshot.connectionState}');
              print('snapshot: ${snapshot.data}');
              if (snapshot.hasData) {
                var users = snapshot.data;
                if (users == null || users.isEmpty) {
                  return const Center(
                    child: Text('No data'),
                  );
                }

                users = users
                    .where((element) =>
                        '${element.userMetadata!['fName']} ${element.userMetadata!['lName']}'
                            .toLowerCase()
                            .contains(context
                                .watch<UserProvider>()
                                .searchText
                                .toLowerCase()))
                    .toList();

                List<String> roles = [
                  if (context.watch<UserProvider>().adminIsChecked) 'ADMIN',
                  if (context.watch<UserProvider>().cookerIsChecked) 'COOKER',
                  if (context.watch<UserProvider>().sellerIsChecked) 'SELLER',
                  if (context.watch<UserProvider>().bookIsChecked) 'BOOK',
                ];

                users = users
                    .where((element) =>
                        roles.contains(element.appMetadata!['role']))
                    .toList();

                print('users length: ${users.length}');

                if (users.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data, try another search',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                int nbPages =
                    users.length ~/ context.watch<UserProvider>().nbItemPerPage;
                print('nbPages: $nbPages');
                if (users.length %
                        context.watch<UserProvider>().nbItemPerPage !=
                    0) {
                  nbPages++;
                }
                // add post frame callback to avoid calling setState during build

                return Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: nbPages,
                        itemBuilder: (context, indexPage) {
                          return ListView.builder(
                            padding: const EdgeInsets.all(10),
                            shrinkWrap: true,
                            itemCount:
                                context.watch<UserProvider>().nbItemPerPage,
                            itemBuilder: (context, index) {
                              int correctIndex = indexPage == 0
                                  ? index
                                  : (indexPage *
                                          context
                                              .watch<UserProvider>()
                                              .nbItemPerPage) +
                                      index;
                              if (correctIndex > users!.length - 1) {
                                return Container();
                              }
                              final user = users![correctIndex];

                              print('index: $index');
                              print('indexPage: $indexPage');
                              print(
                                  'correct index: ${indexPage == 0 ? index : (indexPage * context.watch<UserProvider>().nbItemPerPage) + index}');
                              print('-' * 50);

                              return Card(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(0),
                                child: ListTile(
                                  cursor: SystemMouseCursors.click,
                                  onPressed: () {
                                    context.go(
                                        '/user-detail/${user.id.toString()}');
                                  },
                                  leading: Container(
                                    height: 50,
                                    width: 100,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue,
                                            ),
                                            child: Text(
                                              '${user.userMetadata!['fName'].toString().substring(0, 1).toUpperCase()}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(user.userMetadata!['fName'] +
                                      ' ' +
                                      user.userMetadata!['lName']),
                                  subtitle: Text(user.createdAt.toString()),
                                  trailing: Row(
                                    children: [
                                      FilledButton(
                                        style: ButtonStyle(
                                          shape: ButtonState.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          padding: ButtonState.all(
                                              const EdgeInsets.all(8.0)),
                                          backgroundColor:
                                              ButtonState.all(Colors.blue),
                                          foregroundColor:
                                              ButtonState.all(Colors.white),
                                        ),
                                        onPressed: () {
                                          context.go(
                                              '/user/update/${user.id.toString()}');
                                        },
                                        child: const Icon(FluentIcons.edit),
                                      ),
                                      SizedBox(width: 10),
                                      FilledButton(
                                        style: ButtonStyle(
                                          shape: ButtonState.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          padding: ButtonState.all(
                                              const EdgeInsets.all(8.0)),
                                          backgroundColor:
                                              ButtonState.all(Colors.red),
                                          foregroundColor:
                                              ButtonState.all(Colors.white),
                                        ),
                                        onPressed: () {},
                                        child: const Icon(FluentIcons.delete),
                                      ),
                                    ],
                                  ),
                                  /*trailing: Container(
                                    height: 50,
                                    width: 120,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blue,
                                          ),
                                          child: InkWell(
                                            child: Icon(Icons.edit,
                                                color: Colors.white),
                                            onTap: () {
                                              print('edit');

                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.redAccent,
                                          ),
                                          child: InkWell(
                                            child: Icon(Icons.delete,
                                                color: Colors.white),
                                            onTap: () {
                                              print('delete');
                                              print(
                                                  'user id: ${user.id.toString()}');
                                              Get.defaultDialog(
                                                contentPadding:
                                                    EdgeInsets.all(20),
                                                content: Column(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .delete_forever_rounded,
                                                      color: Colors.redAccent,
                                                      size: 100,
                                                    ),
                                                    Text(
                                                        'Are you sure to delete this category? The deletion of this category will delete all products associated with it.'),
                                                  ],
                                                ),
                                                title: 'Delete category',
                                                textConfirm: 'Yes',
                                                textCancel: 'No',
                                                confirmTextColor: Colors.white,
                                                onConfirm: () async {
                                                  bool res = await context
                                                      .read<UserProvider>()
                                                      .deleteUser(
                                                          user.id.toString());
                                                  Get.back();
                                                  if (res) {
                                                    Get.snackbar(
                                                      'Success',
                                                      'Category deleted successfully',
                                                      backgroundColor:
                                                          Colors.green,
                                                      colorText: Colors.white,
                                                    );
                                                  } else {
                                                    Get.snackbar(
                                                      'Error',
                                                      'An error occured while deleting category',
                                                      backgroundColor:
                                                          Colors.red,
                                                      colorText: Colors.white,
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),*/
                                ),
                              );
                            },
                          );
                        },
                        controller: pageController,
                      ),
                    ),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(FluentIcons.back, color: Colors.black),
                            onPressed: () {
                              pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: '${currentPage + 1}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              children: [
                                TextSpan(
                                  text: '/$nbPages',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon:
                                Icon(FluentIcons.forward, color: Colors.black),
                            onPressed: () {
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: ProgressRing(),
              );
            },
          ),
        ),
      ],
    );
  }
}
