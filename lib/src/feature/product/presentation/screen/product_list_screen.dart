import 'dart:js_interop';

import 'package:admin_dashboard/src/feature/category/data/datasource/category_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/datasource/product_datasource.dart';
import '../../data/model/product_model.dart';
import '../provider/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  PageController mainPageController;

  ProductListScreen({super.key, required this.mainPageController});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  int nbPages = 0;

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
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.blueAccent,
              width: 4,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: FormBuilderTextField(
                  name: 'sarch',
                  controller: context.watch<ProductProvider>().searchController,
                  onChanged: (value) {
                    print('value: $value');
                    context.read<ProductProvider>().setSearchText(value!);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: InkWell(
                      child: Icon(Icons.clear),
                      onTap: () {
                        context.read<ProductProvider>().setSearchText('');
                        context.read<ProductProvider>().setTextController('');
                      },
                    ),
                    contentPadding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxHeight: 40,
                    ),
                    hintText: 'Search a product ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
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
                      context.read<ProductProvider>().setNbItemPerPage(value!);
                    },
                    initialValue:
                        context.watch<ProductProvider>().nbItemPerPage,
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
              ),
              SizedBox(width: 10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent,
                ),
                child: InkWell(
                  child: Icon(Icons.add, color: Colors.white),
                  onTap: () {
                    /*print('add');
                    context.read<ProductProvider>().setProductModel(null);

                    widget.mainPageController.jumpToPage(7);*/

                    context.go('/product-add');
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: ProductDataSource().getProductByIdStream(),
            builder: (context, snapshot) {
              print('snapshot: ${snapshot.connectionState}');
              print('snapshot: ${snapshot.data}');
              if (snapshot.hasData) {
                var categories = snapshot.data;
                if (categories == null || categories.isEmpty) {
                  return const Center(
                    child: Text('No data'),
                  );
                }
                categories = categories
                    .where((element) => element['name']
                        .toString()
                        .toLowerCase()
                        .contains(context
                            .watch<ProductProvider>()
                            .searchText
                            .toLowerCase()))
                    .toList();
                print('categories: ${categories.length}');

                if (categories.isEmpty &&
                    context.watch<ProductProvider>().searchText.isNotEmpty) {
                  return const Center(
                    child: Text(
                      'No data, try another search',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                int nbPages = categories.length ~/
                    context.watch<ProductProvider>().nbItemPerPage;
                print('nbPages: $nbPages');
                if (categories.length %
                        context.watch<ProductProvider>().nbItemPerPage !=
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
                                context.watch<ProductProvider>().nbItemPerPage,
                            itemBuilder: (context, index) {
                              int correctIndex = indexPage == 0
                                  ? index
                                  : (indexPage *
                                          context
                                              .watch<ProductProvider>()
                                              .nbItemPerPage) +
                                      index;
                              if (correctIndex > categories!.length - 1) {
                                return Container();
                              }
                              final product = ProductModel.fromJson(
                                  categories![correctIndex]);
                              print('index: $index');
                              print('indexPage: $indexPage');
                              print(
                                  'correct index: ${indexPage == 0 ? index : (indexPage * context.watch<ProductProvider>().nbItemPerPage) + index}');
                              print('-' * 50);

                              return Card(
                                child: ListTile(
                                  tileColor: Colors.grey[200],
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
                                              '${product.id}',
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
                                            color: Colors.blueAccent,
                                          ),
                                          child: FutureBuilder<String?>(
                                            future: context
                                                .read<ProductProvider>()
                                                .getSignedUrl(
                                                    product?.imageUrl ?? ''),
                                            builder: (context, snapshot) {
                                              print(
                                                  'snapshot stqte: ${snapshot.connectionState}');
                                              print(
                                                  'snapshot: ${snapshot.data}');
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.hasData) {
                                                  return Image.network(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(
                                                          Icons.error,
                                                          color: Colors.white);
                                                    },
                                                  );
                                                } else {
                                                  return const Icon(Icons.error,
                                                      color: Colors.white);
                                                }
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(product?.name ?? ''),
                                  subtitle: Text(product?.description ?? ''),
                                  trailing: Container(
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
                                            color: Colors.blueAccent,
                                          ),
                                          child: InkWell(
                                            child: Icon(Icons.edit,
                                                color: Colors.white),
                                            onTap: () {
                                              print('edit');
                                              context.go('/product-update/${product.id}');
                                              /*widget.mainPageController
                                                  .jumpToPage(8);
                                              context
                                                  .read<ProductProvider>()
                                                  .setProductModel(product);*/
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
                                                  'category id: ${product.id}');
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
                                                      .read<ProductProvider>()
                                                      .deleteProduct(
                                                          product.id);
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
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        controller: pageController,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 4,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              children: [
                                TextSpan(
                                  text: '/$nbPages',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
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
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
