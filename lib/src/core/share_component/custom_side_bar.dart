import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../feature/auth/presentation/provider/auth_provider.dart';
import '../../feature/home/presentation/provider/home_provider.dart';

class SideBarCustomWidget extends StatefulWidget {
/*
  bool sideBarIsCollapsed;
*/
  int selectedIndex;

  SideBarCustomWidget({super.key,
/*
      required this.sideBarIsCollapsed,
*/
    required this.selectedIndex});

  @override
  State<SideBarCustomWidget> createState() => _SideBarCustomWidgetState();
}

class _SideBarCustomWidgetState extends State<SideBarCustomWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    print('initState');
    print('widget.currentIndex ${widget.selectedIndex}');
    bool isCollapsed = context
        .read<HomeProvider>()
        .isCollapsed;
    _controller = AnimationController(
      value: isCollapsed ? 0 : 1,
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          context.read<HomeProvider>().setCollapsed(false);
        });
      } else if (status == AnimationStatus.reverse) {
        setState(() {
          context.read<HomeProvider>().setCollapsed(true);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        print(_controller.value);
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(12),
              ),
              color: Colors.blue,
            ),
            width: 60 + _controller.value * 200,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: child!);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: !context
                  .watch<HomeProvider>()
                  .isCollapsed
                  ? EdgeInsets.all(8)
                  : EdgeInsets.all(0),
              width: double.infinity,

/*
              margin: EdgeInsets.all(8),
*/
              child: !context
                  .watch<HomeProvider>()
                  .isCollapsed
                  ? Column(
                mainAxisAlignment:
                context
                    .watch<HomeProvider>()
                    .isCollapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/330/330703.png'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'John Smith',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
                  : Container(
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/330/330703.png'),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ItemSideBarWidget(
                    children: [],
                    isCollapsed: context
                        .watch<HomeProvider>()
                        .isCollapsed,
                    mainItemSideBarWidget: MainItemSideBarWidget(
                      isSelect: widget.selectedIndex == 0,
                      mainIcon: Icon(Icons.home),
                      mainText: 'Home',
                      onTap: () {
                        context.go('/home');
                      },
                    ),
                  ),
                  ItemSideBarWidget(
                    childrenAreCollapsed:
                    context
                        .watch<HomeProvider>()
                        .categoryIsCollapsed,
                    onTapChildren: () {
                      context.read<HomeProvider>().setCategoryCollapsed(
                          !context
                              .read<HomeProvider>()
                              .categoryIsCollapsed);
                    },
                    mainItemSideBarWidget: MainItemSideBarWidget(
                      isSelect: widget.selectedIndex == 1 ||
                          widget.selectedIndex == 2,
                      mainIcon: Icon(Icons.category),
                      mainText: 'Categories',
                      onTap: () {
                        context.go('/category-list');
                      },
                    ),
                    children: [
                      SubItemSideBarWidget(
                        isSelect: widget.selectedIndex == 1,
                        subIcon: const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 10),
                        subText: 'Category List',
                        onTap: () {
                          print('Category List');

                          context.go('/category-list');
                        },
                      ),
                      SubItemSideBarWidget(
                        isSelect: widget.selectedIndex == 2,
                        subIcon: const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 10),
                        subText: 'Add Category',
                        onTap: () {
                          context.go('/category-add');
                        },
                      ),
                    ],
                    isCollapsed: context
                        .watch<HomeProvider>()
                        .isCollapsed,
                  ),
                  ItemSideBarWidget(
                    childrenAreCollapsed:
                    context
                        .watch<HomeProvider>()
                        .productIsCollapsed,
                    onTapChildren: () {
                      context.read<HomeProvider>().setProductCollapsed(
                          !context
                              .read<HomeProvider>()
                              .productIsCollapsed);
                    },
                    mainItemSideBarWidget: MainItemSideBarWidget(
                      isSelect: widget.selectedIndex == 3 ||
                          widget.selectedIndex == 4,
                      mainIcon: Icon(Icons.cake_rounded),
                      mainText: 'Products',
                      onTap: () {
                        context.go('/product-list');
                      },
                    ),
                    children: [
                      SubItemSideBarWidget(
                        isSelect: widget.selectedIndex == 3,
                        subIcon: const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 10),
                        subText: 'Product List',
                        onTap: () {
                          context.go('/product-list');
                        },
                      ),
                      SubItemSideBarWidget(
                        isSelect: widget.selectedIndex == 4,
                        subIcon: const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 10),
                        subText: 'Add Product',
                        onTap: () {
                          context.go('/product-add');
                        },
                      ),
                    ],
                    isCollapsed: context
                        .watch<HomeProvider>()
                        .isCollapsed,
                  ),
                  ItemSideBarWidget(
                    children: [],
                    isCollapsed: context
                        .watch<HomeProvider>()
                        .isCollapsed,
                    mainItemSideBarWidget: MainItemSideBarWidget(
                      isSelect: widget.selectedIndex == 5,
                      mainIcon: Icon(Icons.shopping_cart_outlined),
                      mainText: 'Orders',
                      onTap: () {
                        context.go('/order-list');
                      },
                    ),
                  ),
                  ItemSideBarWidget(
                    childrenAreCollapsed:
                    context
                        .watch<HomeProvider>()
                        .userIsCollapsed,
                    onTapChildren: () {
                      context.read<HomeProvider>().setUserCollapsed(
                          !context
                              .read<HomeProvider>()
                              .userIsCollapsed);
                    },
                    mainItemSideBarWidget: MainItemSideBarWidget(
                      isSelect: widget.selectedIndex == 6 ||
                          widget.selectedIndex == 7,
                      mainIcon: Icon(Icons.group),
                      mainText: 'Users',
                      onTap: () {
                        context.go('/user-list');
                      },
                    ),
                    children: [
                      SubItemSideBarWidget(
                        isSelect: widget.selectedIndex == 6,
                        subIcon: const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 10),
                        subText: 'User List',
                        onTap: () {
                          context.go('/user-list');
                        },
                      ),
                      SubItemSideBarWidget(
                        isSelect: widget.selectedIndex == 7,
                        subIcon: const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 10),
                        subText: 'Add User',
                        onTap: () {
                          context.go('/user-add');
                        },
                      ),
                    ],
                    isCollapsed: context
                        .watch<HomeProvider>()
                        .isCollapsed,
                  ),
                  ItemSideBarWidget(
                    childrenAreCollapsed:
                    context
                        .watch<HomeProvider>()
                        .bookIsCollapsed,
                    onTapChildren: () {
                      context.read<HomeProvider>().setBookCollapsed(
                          !context
                              .read<HomeProvider>()
                              .bookIsCollapsed);
                    },
                    mainItemSideBarWidget: MainItemSideBarWidget(
                      isSelect: widget.selectedIndex == 8 ||
                          widget.selectedIndex == 9,
                      mainIcon: Icon(Icons.chrome_reader_mode_rounded),
                      mainText: 'Book',
                      onTap: () {},
                    ),
                    children: [
                      SubItemSideBarWidget(
                        isSelect: widget.selectedIndex == 8,
                        subIcon: const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 10),
                        subText: 'Page List',
                        onTap: () {},
                      ),
                      SubItemSideBarWidget(
                        isSelect: widget.selectedIndex == 9,
                        subIcon: const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 10),
                        subText: 'Add Page',
                        onTap: () {},
                      ),
                    ],
                    isCollapsed: context
                        .watch<HomeProvider>()
                        .isCollapsed,
                  ),
                  ItemSideBarWidget(
                    children: [],
                    isCollapsed: context
                        .watch<HomeProvider>()
                        .isCollapsed,
                    mainItemSideBarWidget: MainItemSideBarWidget(
                      isSelect: widget.selectedIndex == 10,
                      mainIcon: Icon(Icons.settings),
                      mainText: 'Settings',
                      onTap: () {},
                    ),
                  ),
                  ItemSideBarWidget(
                    children: [],
                    isCollapsed: context
                        .watch<HomeProvider>()
                        .isCollapsed,
                    mainItemSideBarWidget: MainItemSideBarWidget(
                      isSelect: widget.selectedIndex == 11,
                      mainIcon: Icon(Icons.logout),
                      mainText: 'Logout',
                      onTap: () {
                        context.read<AuthProvider>().logout();
                        context.go('/login');
                      },
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 3.14,
                  child: child,
                );
              },
              child: IconButton(
                onPressed: () {
                  if (context
                      .read<HomeProvider>()
                      .isCollapsed) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemSideBarWidget extends StatefulWidget {
  bool? childrenAreCollapsed;
  Function()? onTapChildren;
  bool isCollapsed;
  MainItemSideBarWidget mainItemSideBarWidget;
  List<SubItemSideBarWidget> children;

  ItemSideBarWidget({
    super.key,
    required this.children,
    required this.isCollapsed,
    required this.mainItemSideBarWidget,
    this.childrenAreCollapsed,
    this.onTapChildren,
  });

  @override
  State<ItemSideBarWidget> createState() => _ItemSideBarWidgetState();
}

class _ItemSideBarWidgetState extends State<ItemSideBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: widget.mainItemSideBarWidget.isSelect
              ? Colors.white
              : Colors.transparent,
          width: 1,
        ),
      ),
      duration: Duration(milliseconds: 500),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 50,
            ),
            child: InkWell(
              onTap: () {
                widget.mainItemSideBarWidget.onTap();
              },
              child: Row(
                mainAxisAlignment: widget.isCollapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  widget.mainItemSideBarWidget.mainIcon,
                  if (!widget.isCollapsed)
                    SizedBox(
                      width: 10,
                    ),
                  if (!widget.isCollapsed)
                    Expanded(
                      child: Text(widget.mainItemSideBarWidget.mainText),
                    ),
                  if (!widget.isCollapsed && widget.children.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        if (widget.childrenAreCollapsed!) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                        widget.onTapChildren!();
                        /*setState(() {
                          childrenAreCollapsed = !childrenAreCollapsed;
                        });*/
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (widget.childrenAreCollapsed != null &&
              !widget.childrenAreCollapsed! &&
              widget.children.isNotEmpty &&
              !widget.isCollapsed)
            Column(
              children: List.generate(
                widget.children.length,
                    (index) =>
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 50,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: widget.children[index].isSelect
                              ? Colors.white
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          widget.children[index].onTap();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 30,
                              ),
                              child: widget.children[index].subIcon,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(widget.children[index].subText),
                            )
                          ],
                        ),
                      ),
                    ),
              ),
            ),
        ],
      ),
    );
  }
}

class MainItemSideBarWidget {
  bool isSelect;
  Icon mainIcon;
  String mainText;
  Function() onTap;

  MainItemSideBarWidget({required this.mainIcon,
    required this.mainText,
    required this.onTap,
    required this.isSelect});
}

class SubItemSideBarWidget {
  Icon subIcon;
  String subText;
  Function() onTap;
  bool isSelect;

  SubItemSideBarWidget({required this.subIcon,
    required this.subText,
    required this.onTap,
    required this.isSelect});
}
