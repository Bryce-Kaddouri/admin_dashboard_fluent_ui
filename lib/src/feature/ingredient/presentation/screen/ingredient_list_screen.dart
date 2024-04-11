import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:admin_dashboard/src/feature/ingredient/presentation/provider/ingredient_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class IngredientListScreen extends StatefulWidget {
  const IngredientListScreen({super.key});

  @override
  State<IngredientListScreen> createState() => _IngredientListScreenState();
}

class _IngredientListScreenState extends State<IngredientListScreen> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<IngredientProvider>().getIngredients().whenComplete(() => setState(() => isLoading = false));
    pageController.addListener(() {
      print('pageController.page: ${pageController.page}');
      setState(() {
        currentPage = pageController.page!.toInt();
      });
    });
    searchController.addListener(() {
      context.read<IngredientProvider>().setSearchText(searchController.text);
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          currentPage = pageController.page!.toInt();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    controller: searchController,
                    onChanged: (value) {
                      context.read<IngredientProvider>().setSearchText(value);
                    },
                    suffixMode: OverlayVisibilityMode.editing,
                    suffix: Button(
                      style: ButtonStyle(
                        elevation: ButtonState.all(0),
                        padding: ButtonState.all(const EdgeInsets.all(4)),
                      ),
                      onPressed: () {
                        context.read<IngredientProvider>().setSearchText('');
                        searchController.clear();
                      },
                      child: Container(
                        height: 16,
                        width: 16,
                        child: Icon(FluentIcons.clear, color: FluentTheme.of(context).typography.caption!.color),
                      ),
                    ),
                    prefixMode: OverlayVisibilityMode.always,
                    prefix: Container(padding: const EdgeInsets.symmetric(horizontal: 10.0), child: Icon(FluentIcons.search, size: 20, color: FluentTheme.of(context).typography.caption!.color)),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: BoxDecoration(
                      color: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
              DropDownButton(
                title: Text(
                  context.watch<IngredientProvider>().nbItemPerPage.toString(),
                ),
                items: [
                  MenuFlyoutItem(
                      selected: context.watch<IngredientProvider>().nbItemPerPage == 10,
                      leading: context.watch<IngredientProvider>().nbItemPerPage == 10
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              width: 4,
                              height: 16,
                            )
                          : null,
                      text: const Text('10'),
                      onPressed: () {
                        context.read<IngredientProvider>().setNbItemPerPage(10);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      }),
                  MenuFlyoutSeparator(),
                  MenuFlyoutItem(
                      selected: context.watch<IngredientProvider>().nbItemPerPage == 25,
                      leading: context.watch<IngredientProvider>().nbItemPerPage == 25
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              width: 4,
                              height: 16,
                            )
                          : null,
                      text: const Text('25'),
                      onPressed: () {
                        context.read<IngredientProvider>().setNbItemPerPage(25);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      }),
                  MenuFlyoutSeparator(),
                  MenuFlyoutItem(
                      selected: context.watch<IngredientProvider>().nbItemPerPage == 50,
                      leading: context.watch<IngredientProvider>().nbItemPerPage == 50
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              width: 4,
                              height: 16,
                            )
                          : null,
                      text: const Text('50'),
                      onPressed: () {
                        context.read<IngredientProvider>().setNbItemPerPage(50);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      }),
                  MenuFlyoutSeparator(),
                  MenuFlyoutItem(
                      selected: context.watch<IngredientProvider>().nbItemPerPage == 100,
                      leading: context.watch<IngredientProvider>().nbItemPerPage == 100
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              width: 4,
                              height: 16,
                            )
                          : null,
                      text: const Text('100'),
                      onPressed: () {
                        context.read<IngredientProvider>().setNbItemPerPage(100);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      }),
                  MenuFlyoutSeparator(),
                  MenuFlyoutItem(
                      selected: context.watch<IngredientProvider>().nbItemPerPage == 250,
                      leading: context.watch<IngredientProvider>().nbItemPerPage == 250
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              width: 4,
                              height: 16,
                            )
                          : null,
                      text: const Text('250'),
                      onPressed: () {
                        context.read<IngredientProvider>().setNbItemPerPage(250);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      }),
                ],
              ),
              SizedBox(width: 10),
              FilledButton(
                style: ButtonStyle(
                  shape: ButtonState.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  padding: ButtonState.all(const EdgeInsets.all(8.0)),
                  backgroundColor: ButtonState.all(Colors.blue),
                  foregroundColor: ButtonState.all(Colors.white),
                ),
                onPressed: () {
                  context.go('/ingredient/add');
                },
                child: const Icon(FluentIcons.add),
              ),
            ],
          ),
        ),
        Expanded(
          child:
              /*FutureBuilder<List<Ingredient>>(
            future: context.read<ProductProvider>().getProducts(),
            builder: (context, snapshot) {
              print('snapshot: ${snapshot.connectionState}');
              print('snapshot: ${snapshot.data}');*/
              Builder(
            builder: (context) {
              if (!isLoading) {
                List<IngredientModel> ingredients = context.watch<IngredientProvider>().ingredients;
                if (ingredients == null || ingredients.isEmpty) {
                  return const Center(
                    child: Text('No data'),
                  );
                }
                ingredients = ingredients.where((element) => element.name.toString().toLowerCase().contains(context.watch<IngredientProvider>().searchText.toLowerCase())).toList();

                if (ingredients.isEmpty && context.watch<IngredientProvider>().searchText.isNotEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FluentIcons.search, size: 60, color: FluentTheme.of(context).typography.caption!.color),
                      SizedBox(height: 10),
                      Text(
                        'No data, try another search',
                        style: FluentTheme.of(context).typography.body!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  );
                }

                List<List<IngredientModel>> ingredientList = [];
                for (int i = 0; i < ingredients.length; i++) {
                  if (ingredientList.isEmpty) {
                    ingredientList.add([ingredients[i]]);
                  } else if (ingredientList.last.length < context.watch<IngredientProvider>().nbItemPerPage) {
                    ingredientList[(ingredientList.length > 0 ? ingredientList.length : 1) - 1].add(ingredients[i]);
                  } else {
                    ingredientList.add([ingredients[i]]);
                  }
                }

                return Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: ingredientList.length,
                        itemBuilder: (context, indexPage) {
                          return ListView.builder(
                            padding: const EdgeInsets.all(10),
                            shrinkWrap: true,
                            itemCount: ingredientList[indexPage].length, //products.length,
                            itemBuilder: (context, index) {
                              IngredientModel product = ingredientList[indexPage][index];

                              return Card(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(0),
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 100,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${product.id}',
                                              style: FluentTheme.of(context).typography.body!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.blue,
                                          ),
                                          child: Image.network(
                                            product.photoUrl ?? '',
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(FluentIcons.photo_error, color: Colors.white);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(product?.name ?? ''),
                                  subtitle: Text(product?.type.name ?? ''),
                                  trailing: Row(
                                    children: [
                                      FilledButton(
                                        style: ButtonStyle(
                                          shape: ButtonState.all(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                          padding: ButtonState.all(const EdgeInsets.all(8.0)),
                                          backgroundColor: ButtonState.all(Colors.blue),
                                          foregroundColor: ButtonState.all(Colors.white),
                                        ),
                                        onPressed: () {
                                          context.go('/product/update/${product.id}');
                                        },
                                        child: const Icon(FluentIcons.edit),
                                      ),
                                      SizedBox(width: 10),
                                      FilledButton(
                                        style: ButtonStyle(
                                          shape: ButtonState.all(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                          padding: ButtonState.all(const EdgeInsets.all(8.0)),
                                          backgroundColor: ButtonState.all(Colors.red),
                                          foregroundColor: ButtonState.all(Colors.white),
                                        ),
                                        onPressed: () async {
                                          print('delete');
                                          /*Get.defaultDialog(
                                            contentPadding: EdgeInsets.all(20),
                                            content: Column(
                                              children: [
                                                Icon(
                                                  FluentIcons.delete,
                                                  color: Colors.red,
                                                  size: 100,
                                                ),
                                                Text(
                                                    'Are you sure to delete this Product? The deletion of this category will delete all order associated with it.'),
                                              ],
                                            ),
                                            title: 'Delete Product',
                                            textConfirm: 'Yes',
                                            textCancel: 'No',
                                            confirmTextColor: Colors.white,
                                            onConfirm: () async {
                                              bool res = await context
                                                  .read<ProductProvider>()
                                                  .deleteProduct(product.id);
                                              Get.back();
                                              if (res) {
                                                Get.snackbar(
                                                  'Success',
                                                  'Category deleted successfully',
                                                  backgroundColor: Colors.green,
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
                                          );*/
                                          bool? confirmed = await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ContentDialog(
                                                  title: Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    child: Text(
                                                      'Delete Product',
                                                      style: FluentTheme.of(context).typography.title!.copyWith(
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        FluentIcons.delete,
                                                        color: Colors.red,
                                                        size: 60,
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        'Are you sure to delete this Product?\n\nThe deletion of this category will delete all order associated with it.',
                                                        style: FluentTheme.of(context).typography.body!.copyWith(
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    FilledButton(
                                                      onPressed: () async {
/*
                                                        bool res = await context.read<ProductProvider>().deleteProduct(product.id);
*/
                                                        Navigator.of(context).pop(true);
                                                      },
                                                      child: Text('Yes'),
                                                    ),
                                                    Button(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(false);
                                                      },
                                                      child: Text('No'),
                                                    ),
                                                  ],
                                                );
                                              });
                                          if (confirmed != null && confirmed) {
                                            bool res = true /* await context.read<ProductProvider>().deleteProduct(product.id)*/;
                                            if (res) {
                                              await displayInfoBar(
                                                context,
                                                builder: (context, close) {
                                                  return InfoBar(
                                                    title: const Text('Success'),
                                                    content: Text("Product deleted successfully"),
                                                    severity: InfoBarSeverity.success,
                                                    isLong: false,
                                                    action: IconButton(
                                                      icon: const Icon(FluentIcons.clear),
                                                      onPressed: close,
                                                    ),
                                                  );
                                                },
                                                alignment: Alignment.topRight,
                                              );
                                            } else {
                                              await displayInfoBar(
                                                context,
                                                builder: (context, close) {
                                                  return InfoBar(
                                                    title: const Text('Error'),
                                                    content: Container(
                                                      child: Text("Something went wrong"),
                                                    ),
                                                    severity: InfoBarSeverity.error,
                                                    isLong: false,
                                                    action: IconButton(
                                                      icon: const Icon(FluentIcons.clear),
                                                      onPressed: close,
                                                    ),
                                                  );
                                                },
                                                alignment: Alignment.topRight,
                                              );
                                            }
                                          }
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
                            icon: Icon(FluentIcons.back, color: FluentTheme.of(context).typography.subtitle!.color),
                            onPressed: () {
                              pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: '${currentPage + 1}',
                              style: FluentTheme.of(context).typography.subtitle!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              children: [
                                TextSpan(
                                  text: '/${ingredientList.length}',
                                  style: FluentTheme.of(context).typography.subtitle!.copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(FluentIcons.forward, color: FluentTheme.of(context).typography.subtitle!.color),
                            onPressed: () {
                              pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
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
