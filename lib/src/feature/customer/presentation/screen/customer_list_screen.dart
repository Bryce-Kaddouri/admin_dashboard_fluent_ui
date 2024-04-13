import 'package:admin_dashboard/src/feature/customer/presentation/provider/customer_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/model/customer_model.dart';

class CustomerListScreen extends StatefulWidget {
  CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen>
    with AutomaticKeepAliveClientMixin {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  int nbPages = 0;

  TextEditingController searchController = TextEditingController();

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
    searchController.addListener(() {
      print('searchController.text: ${searchController.text}');
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          currentPage = pageController.page!.toInt();
        });
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
                      controller: searchController,
                      prefixMode: OverlayVisibilityMode.always,
                      onChanged: (value) {
                        context.read<CustomerProvider>().setSearchText(value);
                      },
                      suffixMode: OverlayVisibilityMode.editing,
                      suffix: Button(
                        style: ButtonStyle(
                          elevation: ButtonState.all(0),
                          padding: ButtonState.all(const EdgeInsets.all(4)),
                        ),
                        onPressed: () {
                          context.read<CustomerProvider>().setSearchText('');
                          searchController.clear();
                        },
                        child: Container(
                          height: 16,
                          width: 16,
                          child: Icon(FluentIcons.clear,
                              color: FluentTheme.of(context)
                                  .typography
                                  .caption!
                                  .color),
                        ),
                      ),
                      prefix: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(FluentIcons.search,
                              size: 20,
                              color: FluentTheme.of(context)
                                  .typography
                                  .caption!
                                  .color)),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: BoxDecoration(
                        color: FluentTheme.of(context)
                            .navigationPaneTheme
                            .backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                // select between 10, 25, 50, 100 and 250
                DropDownButton(
                  title: Text(
                    context.watch<CustomerProvider>().nbItemPerPage.toString(),
                    style:
                        FluentTheme.of(context).typography.subtitle!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                  ),
                  items: [
                    MenuFlyoutItem(
                      selected:
                          context.watch<CustomerProvider>().nbItemPerPage == 10,
                      leading:
                          context.watch<CustomerProvider>().nbItemPerPage == 10
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
                        context.read<CustomerProvider>().setNbItemPerPage(10);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      },
                    ),
                    MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                      selected:
                          context.watch<CustomerProvider>().nbItemPerPage == 25,
                      leading:
                          context.watch<CustomerProvider>().nbItemPerPage == 25
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
                        context.read<CustomerProvider>().setNbItemPerPage(25);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      },
                    ),
                    MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                      selected:
                          context.watch<CustomerProvider>().nbItemPerPage == 50,
                      leading:
                          context.watch<CustomerProvider>().nbItemPerPage == 50
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
                        context.read<CustomerProvider>().setNbItemPerPage(50);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      },
                    ),
                    MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                      selected:
                          context.watch<CustomerProvider>().nbItemPerPage ==
                              100,
                      leading:
                          context.watch<CustomerProvider>().nbItemPerPage == 100
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
                        context.read<CustomerProvider>().setNbItemPerPage(100);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
                      },
                    ),
                    MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                      selected:
                          context.watch<CustomerProvider>().nbItemPerPage ==
                              250,
                      leading:
                          context.watch<CustomerProvider>().nbItemPerPage == 250
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
                        context.read<CustomerProvider>().setNbItemPerPage(250);
                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            currentPage = pageController.page!.toInt();
                          });
                        });
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
                    context.go('/customer/add');
                  },
                  child: const Icon(FluentIcons.add),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            child: FutureBuilder<List<CustomerModel>>(
              future: context.read<CustomerProvider>().getCustomers(),
              builder: (context, snapshot) {
                print('snapshot: ${snapshot.connectionState}');
                print('snapshot: ${snapshot.data}');
                if (snapshot.hasData) {
                  List<CustomerModel>? customers = snapshot.data;
                  if (customers == null || customers.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  }
                  customers = customers
                      .where((element) => element.fName
                          .toString()
                          .toLowerCase()
                          .contains(context
                              .watch<CustomerProvider>()
                              .searchText
                              .toLowerCase()))
                      .toList();
                  print('categories: ${customers.length}');

                  if (customers.isEmpty &&
                      context.watch<CustomerProvider>().searchText.isNotEmpty) {
                    return const Center(
                      child: Text(
                        'No data, try another search',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  List<List<CustomerModel>> customersList = [];
                  for (int i = 0; i < customers.length; i++) {
                    if (customersList.isEmpty) {
                      customersList.add([customers[i]]);
                    } else if (customersList.last.length <
                        context.watch<CustomerProvider>().nbItemPerPage) {
                      customersList[(customersList.length > 0
                                  ? customersList.length
                                  : 1) -
                              1]
                          .add(customers[i]);
                    } else {
                      customersList.add([customers[i]]);
                    }
                  }

                  // add post frame callback to avoid calling setState during build

                  return Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          itemCount: customersList.length,
                          itemBuilder: (context, indexPage) {
                            return ListView.builder(
                              padding: const EdgeInsets.all(10),
                              shrinkWrap: true,
                              itemCount: customersList[indexPage].length,
                              itemBuilder: (context, index) {
                                CustomerModel customer =
                                    customersList[indexPage][index];

                                return Card(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(0),
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
                                                '${customer.id}',
                                                style: FluentTheme.of(context)
                                                    .typography
                                                    .body!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    title: Text(
                                        '${customer.lName} ${customer.fName}'),
                                    subtitle: Text(
                                        '${customer.countryCode}${customer.phoneNumber}'),
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
                                                'category id: ${customer.id}');
                                            context.go(
                                                '/customer/update/${customer.id}');
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
                                          onPressed: () async {
                                            print('delete');
                                            print(
                                                'category id: ${customer.id}');
                                            bool? confirmed = await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ContentDialog(
                                                    title: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Text(
                                                        'Delete Customer',
                                                        style: FluentTheme.of(
                                                                context)
                                                            .typography
                                                            .title!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          FluentIcons.delete,
                                                          color: Colors.red,
                                                          size: 60,
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text(
                                                          'Are you sure to delete this customer?\n\nThe deletion of this customer will delete all order associated with it.',
                                                          style: FluentTheme.of(
                                                                  context)
                                                              .typography
                                                              .body!
                                                              .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      FilledButton(
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        child: Text('Yes'),
                                                      ),
                                                      Button(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                        child: Text('No'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                            if (confirmed != null &&
                                                confirmed) {
                                              bool res = await context
                                                  .read<CustomerProvider>()
                                                  .deleteCustomer(customer.id);
                                              if (res) {
                                                await displayInfoBar(
                                                  context,
                                                  builder: (context, close) {
                                                    return InfoBar(
                                                      title:
                                                          const Text('Success'),
                                                      content: Text(
                                                          "Customer deleted successfully"),
                                                      severity: InfoBarSeverity
                                                          .success,
                                                      isLong: false,
                                                      action: IconButton(
                                                        icon: const Icon(
                                                            FluentIcons.clear),
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
                                                      title:
                                                          const Text('Error'),
                                                      content: Container(
                                                        child: Text(
                                                            "Something went wrong"),
                                                      ),
                                                      severity:
                                                          InfoBarSeverity.error,
                                                      isLong: false,
                                                      action: IconButton(
                                                        icon: const Icon(
                                                            FluentIcons.clear),
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
                              icon: Icon(FluentIcons.back,
                                  color: FluentTheme.of(context)
                                      .typography
                                      .caption!
                                      .color),
                              onPressed: () {
                                pageController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                            ),
                            RichText(
                              text: TextSpan(
                                text: '${currentPage + 1}',
                                style: FluentTheme.of(context)
                                    .typography
                                    .body!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                children: [
                                  TextSpan(
                                    text: '/${customersList.length}',
                                    style: FluentTheme.of(context)
                                        .typography
                                        .body!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(FluentIcons.forward,
                                  color: FluentTheme.of(context)
                                      .typography
                                      .caption!
                                      .color),
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
