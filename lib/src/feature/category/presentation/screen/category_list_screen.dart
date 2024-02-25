import 'package:admin_dashboard/src/feature/category/data/datasource/category_datasource.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/model/category_model.dart';
import '../category_provider/category_provider.dart';

class CategoryListScreen extends StatefulWidget {
  PageController mainPageController;

  CategoryListScreen({super.key, required this.mainPageController});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen>
    with AutomaticKeepAliveClientMixin {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  int nbPages = 0;

  // Override `wantKeepAlive` when using `AutomaticKeepAliveClientMixin`.
  @override
  bool get wantKeepAlive => true;

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
    return Container(
      child: Column(
        children: [
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
                      onChanged: (value) {
                        context.read<CategoryProvider>().setSearchText(value);
                      },
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // select between 10, 25, 50, 100 and 250
                DropDownButton(
                  title: Text(
                    context.watch<CategoryProvider>().nbItemPerPage.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  items: [
                    MenuFlyoutItem(
                      selected:
                          context.watch<CategoryProvider>().nbItemPerPage == 10,
                      leading:
                          context.watch<CategoryProvider>().nbItemPerPage == 10
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue,
                                  ),
                                  width: 4,
                                  height: 16,
                                )
                              : null,
                      text: Container(
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: Text('10'),
                      ),
                      onPressed: () {
                        context.read<CategoryProvider>().setNbItemPerPage(10);
                      },
                    ),
                    MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                      selected:
                          context.watch<CategoryProvider>().nbItemPerPage == 25,
                      leading:
                          context.watch<CategoryProvider>().nbItemPerPage == 25
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue,
                                  ),
                                  width: 4,
                                  height: 16,
                                )
                              : null,
                      text: Container(
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: Text('25'),
                      ),
                      onPressed: () {
                        context.read<CategoryProvider>().setNbItemPerPage(25);
                      },
                    ),
                    MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                      selected:
                          context.watch<CategoryProvider>().nbItemPerPage == 50,
                      leading:
                          context.watch<CategoryProvider>().nbItemPerPage == 50
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue,
                                  ),
                                  width: 4,
                                  height: 16,
                                )
                              : null,
                      text: Container(
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: Text('50'),
                      ),
                      onPressed: () {
                        context.read<CategoryProvider>().setNbItemPerPage(50);
                      },
                    ),
                    MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                      selected:
                          context.watch<CategoryProvider>().nbItemPerPage ==
                              100,
                      leading:
                          context.watch<CategoryProvider>().nbItemPerPage == 100
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue,
                                  ),
                                  width: 4,
                                  height: 16,
                                )
                              : null,
                      text: Container(
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: Text('100'),
                      ),
                      onPressed: () {
                        context.read<CategoryProvider>().setNbItemPerPage(100);
                      },
                    ),
                    MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                      selected:
                          context.watch<CategoryProvider>().nbItemPerPage ==
                              250,
                      leading:
                          context.watch<CategoryProvider>().nbItemPerPage == 250
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue,
                                  ),
                                  width: 4,
                                  height: 16,
                                )
                              : null,
                      text: Container(
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: Text('250'),
                      ),
                      onPressed: () {
                        context.read<CategoryProvider>().setNbItemPerPage(250);
                      },
                    ),
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
              child: Container(
            child: StreamBuilder<List<CategoryModel>>(
              stream: CategoryDataSource().getCategoryByIdStream(),
              builder: (context, snapshot) {
                print('snapshot: ${snapshot.connectionState}');
                print('snapshot: ${snapshot.data}');
                if (snapshot.hasData) {
                  List<CategoryModel>? categories = snapshot.data;
                  if (categories == null || categories.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  }
                  categories = categories
                      .where((element) => element.name
                          .toString()
                          .toLowerCase()
                          .contains(context
                              .watch<CategoryProvider>()
                              .searchText
                              .toLowerCase()))
                      .toList();
                  print('categories: ${categories.length}');

                  if (categories.isEmpty &&
                      context.watch<CategoryProvider>().searchText.isNotEmpty) {
                    return const Center(
                      child: Text(
                        'No data, try another search',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  int nbPages = categories.length ~/
                      context.watch<CategoryProvider>().nbItemPerPage;
                  print('nbPages: $nbPages');
                  if (categories.length %
                          context.watch<CategoryProvider>().nbItemPerPage !=
                      0) {
                    nbPages++;
                  }
                  // add post frame callback to avoid calling setState during build

                  return Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          itemCount: 2,
                          itemBuilder: (context, indexPage) {
                            return ListView.builder(
                              padding: const EdgeInsets.all(10),
                              shrinkWrap: true,
                              itemCount: /*context.watch<CategoryProvider>().nbItemPerPage*/
                                  10,
                              itemBuilder: (context, index) {
                                int correctIndex = indexPage == 0
                                    ? index
                                    : (indexPage *
                                            context
                                                .watch<CategoryProvider>()
                                                .nbItemPerPage) +
                                        index;
                                if (correctIndex > categories!.length - 1) {
                                  return Container();
                                }
                                final category = categories![correctIndex];
                                print('index: $index');
                                print('indexPage: $indexPage');
                                print(
                                    'correct index: ${indexPage == 0 ? index : (indexPage * context.watch<CategoryProvider>().nbItemPerPage) + index}');
                                print('-' * 50);

                                return Card(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 100,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${category.id}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blue,
                                              ),
                                              child: /*FutureBuilder<String?>(
                                              future: context.read<CategoryProvider>().getSignedUrl(category?.imageUrl ?? ''),
                                              builder: (context, snapshot) {
                                                print('snapshot stqte: ${snapshot.connectionState}');
                                                print('snapshot: ${snapshot.data}');
                                                if (snapshot.connectionState == ConnectionState.done) {
                                                  if (snapshot.hasData) {
                                                    return */
                                                  Image.network(
                                                category.imageUrl ?? '',
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(
                                                      FluentIcons.photo_error,
                                                      color: Colors.white);
                                                },
                                              )
                                              /*} else {
                                                    return const Icon(FluentIcons.photo_error, color: Colors.white);
                                                  }
                                                } else {
                                                  return const Center(
                                                    child: ProgressRing(
                                                    ),
                                                  );
                                                }
                                              },
                                            ),*/
                                              ),
                                        ],
                                      ),
                                    ),
                                    title: Text(category?.name ?? ''),
                                    subtitle: Text(category?.description ?? ''),
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
                                            print(
                                                'category id: ${category.id}');
                                            context.push(
                                                '/category-update/${category.id}');
                                            context
                                                .read<CategoryProvider>()
                                                .setCategoryModel(category);
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
                                          onPressed: () {
                                            print('delete');
                                            print(
                                                'category id: ${category.id}');
                                            Get.defaultDialog(
                                              contentPadding:
                                                  EdgeInsets.all(20),
                                              content: Column(
                                                children: [
                                                  Icon(
                                                    FluentIcons.delete,
                                                    color: Colors.red,
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
                                                    .read<CategoryProvider>()
                                                    .deleteCategory(
                                                        category.id);
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
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                  );
                                                }
                                              },
                                            );
                                          },
                                          child: const Icon(FluentIcons.delete),
                                        ),
                                      ],
                                    ),
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
                              icon: Icon(FluentIcons.forward,
                                  color: Colors.black),
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
          )),
        ],
      ),
    );
  }
}
