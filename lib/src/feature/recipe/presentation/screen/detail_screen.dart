import 'package:admin_dashboard/src/core/helper/responsive_helper.dart';
import 'package:admin_dashboard/src/core/share_component/dismiss_keyboard.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:admin_dashboard/src/feature/recipe/data/model/recipe_model.dart';
import 'package:admin_dashboard/src/feature/recipe/presentation/provider/recipe_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  final int id;
  const RecipeDetailScreen({super.key, required this.id});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  RecipeModel? recipe;
  bool isLoading = true;
  double quantity = 1.0;
  SolidUnit solidUnit = SolidUnit.kg;
  FocusNode qtyFocusNode = FocusNode();
  List<bool> ingredientsDone = [];
  bool isList = false;

  void addQuantity() {
    setState(() {
      quantity++;
    });
  }

  void removeQuantity() {
    if (quantity == 1) return;
    setState(() {
      quantity--;
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<RecipeProvider>().getRecipeById(widget.id).then((value) {
      setState(() {
        print(value);
        recipe = value;
        ingredientsDone =
            List.generate(recipe!.ingredients.length, (index) => false);
        isLoading = false;
      });
    });

    qtyFocusNode.addListener(() {
      if (!qtyFocusNode.hasFocus) {
        qtyFocusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      backgroundColor:
          FluentTheme.of(context).navigationPaneTheme.backgroundColor,
      appBar: material.AppBar(
        elevation: 4,
        shadowColor: FluentTheme.of(context).shadowColor,
        surfaceTintColor:
            FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        backgroundColor:
            FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        centerTitle: true,
        title: Text('Recipe Detail'),
        leading: material.BackButton(
          onPressed: () {
            context.go('/recipe');
          },
        ),
      ),
      body: DismissKeyboard(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: isLoading
                ? Center(child: ProgressRing())
                : recipe == null
                    ? Center(child: Text('No recipe found'))
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: Card(
                                        padding: EdgeInsets.all(0),
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    color: FluentTheme.of(
                                                            context)
                                                        .scaffoldBackgroundColor,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: IconButton(
                                                icon: Icon(FluentIcons.remove),
                                                onPressed: () {
                                                  removeQuantity();
                                                },
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              child: NumberBox(
                                                focusNode: qtyFocusNode,
                                                min: 0.1,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9.]')),
                                                ],
                                                mode: SpinButtonPlacementMode
                                                    .none,
                                                clearButton: false,
                                                textAlign: TextAlign.center,
                                                value: quantity,
                                                onTextChange: (value) {
                                                  double val =
                                                      double.tryParse(value!) ??
                                                          1;
                                                  setState(() {
                                                    quantity = val;
                                                  });
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    quantity = value!;
                                                  });
                                                },
                                                style: FluentTheme.of(context)
                                                    .typography
                                                    .bodyStrong!
                                                    .copyWith(fontSize: 20),
                                                /*Text('${(quantity)} ${solidUnit.name}', style: FluentTheme.of(context).typography.bodyStrong)*/
                                              ),
                                              /*Text('${(quantity)} ${solidUnit.name}', style: FluentTheme.of(context).typography.bodyStrong)*/
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: FluentTheme.of(
                                                            context)
                                                        .scaffoldBackgroundColor,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: IconButton(
                                                icon: Icon(FluentIcons.add),
                                                onPressed: () {
                                                  addQuantity();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 40,
                                      child: ComboBox<SolidUnit>(
                                        value: solidUnit,
                                        items: [
                                          SolidUnit.mg,
                                          SolidUnit.g,
                                          SolidUnit.kg
                                        ]
                                            .map((e) => ComboBoxItem<SolidUnit>(
                                                  child: Text(e.name),
                                                  value: e,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            solidUnit = SolidUnit.values
                                                .firstWhere((element) =>
                                                    element == value);
                                          });

                                          if (value == SolidUnit.kg) {}
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: IconButton(
                                        iconButtonMode: IconButtonMode.large,
                                        icon: Icon(
                                          color: FluentTheme.of(context)
                                              .typography
                                              .title!
                                              .color!
                                              .withOpacity(isList ? 0.5 : 1),
                                          FluentIcons.view_all2,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isList = false;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: IconButton(
                                        iconButtonMode: IconButtonMode.large,
                                        icon: Icon(
                                          color: FluentTheme.of(context)
                                              .typography
                                              .title!
                                              .color!
                                              .withOpacity(isList ? 1 : 0.5),
                                          FluentIcons.thumbnail_view,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isList = true;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: FluentTheme.of(context).accentColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text('Ingredients',
                                      style: FluentTheme.of(context)
                                          .typography
                                          .title),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: FluentTheme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // list
                                if (isList) {
                                  int nbColumn =
                                      ResponsiveHelper.isMobile(context)
                                          ? 1
                                          : ResponsiveHelper.isTablet(context)
                                              ? 2
                                              : 3;

                                  int nbRow =
                                      (recipe!.ingredients.length / nbColumn)
                                          .ceil();
                                  return Column(
                                      children: List.generate(
                                    nbRow,
                                    (index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children:
                                          List.generate(nbColumn, (index2) {
                                        int index3 = index * nbColumn + index2;
                                        if (index3 >=
                                            recipe!.ingredients.length) {
                                          return Expanded(child: Container());
                                        }

                                        return Expanded(
                                            child: Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      height: 24,
                                                      width: 24,
                                                      child: Checkbox(
                                                        style:
                                                            CheckboxThemeData(
                                                          checkedIconColor:
                                                              ButtonState.all(
                                                                  Colors.white),
                                                          uncheckedDecoration:
                                                              ButtonState.all(
                                                            BoxDecoration(
                                                              color: Colors
                                                                  .transparent,
                                                              border: Border.all(
                                                                  color: FluentTheme.of(
                                                                          context)
                                                                      .typography
                                                                      .body!
                                                                      .color!),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                          ),
                                                          checkedDecoration:
                                                              ButtonState.all(
                                                            BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                          ),
                                                        ),
                                                        checked:
                                                            ingredientsDone[
                                                                index3],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            ingredientsDone[
                                                                    index3] =
                                                                value!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: Builder(
                                                        builder: (context) {
                                                          int diviser =
                                                              solidUnit ==
                                                                      SolidUnit
                                                                          .kg
                                                                  ? 1
                                                                  : solidUnit ==
                                                                          SolidUnit
                                                                              .g
                                                                      ? 1000
                                                                      : 1000000;

                                                          IngredientType type =
                                                              recipe!
                                                                  .ingredients[
                                                                      index3]
                                                                  .type!;
                                                          String unitTest =
                                                              NumberUnit.unit
                                                                  .toString()
                                                                  .split('.')
                                                                  .last;
                                                          double totalQty = recipe!
                                                                  .ingredients[
                                                                      index3]
                                                                  .quantity *
                                                              (quantity /
                                                                  diviser);
                                                          if (type ==
                                                              IngredientType
                                                                  .solid) {
                                                            unitTest = SolidUnit
                                                                .g
                                                                .toString()
                                                                .split('.')
                                                                .last;

                                                            if (totalQty < 1) {
                                                              unitTest =
                                                                  SolidUnit
                                                                      .mg
                                                                      .toString()
                                                                      .split(
                                                                          '.')
                                                                      .last;
                                                              totalQty =
                                                                  totalQty *
                                                                      100;
                                                            } else if (totalQty >=
                                                                1000) {
                                                              unitTest =
                                                                  SolidUnit
                                                                      .kg
                                                                      .toString()
                                                                      .split(
                                                                          '.')
                                                                      .last;
                                                              totalQty =
                                                                  totalQty /
                                                                      1000;
                                                            }
                                                          } else if (type ==
                                                              IngredientType
                                                                  .liquid) {
                                                            unitTest =
                                                                LiquidUnit.l
                                                                    .toString()
                                                                    .split('.')
                                                                    .last;
                                                            if (totalQty < 1) {
                                                              unitTest =
                                                                  LiquidUnit.ml
                                                                      .toString()
                                                                      .split(
                                                                          '.')
                                                                      .last;
                                                              totalQty =
                                                                  totalQty *
                                                                      1000;
                                                            } else if (totalQty >=
                                                                1000) {
                                                              unitTest =
                                                                  LiquidUnit.kl
                                                                      .toString()
                                                                      .split(
                                                                          '.')
                                                                      .last;
                                                              totalQty =
                                                                  totalQty /
                                                                      1000;
                                                            }
                                                          }

                                                          return Text(
                                                            '${totalQty} ${unitTest}',
                                                            style:
                                                                FluentTheme.of(
                                                                        context)
                                                                    .typography
                                                                    .bodyStrong,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: Text(
                                                        recipe!
                                                            .ingredients[index3]
                                                            .name!,
                                                        style: FluentTheme.of(
                                                                context)
                                                            .typography
                                                            .body,
                                                      ),
                                                    ),
                                                  ],
                                                )));
                                      }),
                                    ),
                                  ));
                                }

                                // grid

                                double nbItemPerRow =
                                    constraints.maxWidth / 120;
                                int nbRow =
                                    (recipe!.ingredients.length / nbItemPerRow)
                                        .ceil();

                                return Column(
                                  children: List.generate(nbRow, (index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                            nbItemPerRow.toInt(), (index2) {
                                          int index3 =
                                              index * nbItemPerRow.toInt() +
                                                  index2;
                                          if (index3 >=
                                              recipe!.ingredients.length) {
                                            return Expanded(child: Container());
                                          }

                                          return Expanded(
                                            child: Column(
                                              children: [
                                                Card(
                                                  padding: EdgeInsets.all(0),
                                                  child: Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      child: Image(
                                                        image: NetworkImage(
                                                            recipe!
                                                                    .ingredients[
                                                                        index3]
                                                                    .photoUrl ??
                                                                ''),
                                                        frameBuilder: (context,
                                                            child,
                                                            frame,
                                                            wasSynchronouslyLoaded) {
                                                          if (wasSynchronouslyLoaded) {
                                                            return child;
                                                          }
                                                          return AnimatedOpacity(
                                                            child: child,
                                                            opacity:
                                                                frame == null
                                                                    ? 0
                                                                    : 1,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 1),
                                                            curve:
                                                                Curves.easeOut,
                                                          );
                                                        },
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                            child: ProgressRing(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        },
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                              child: Icon(
                                                                  FluentIcons
                                                                      .cake));
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(2),
                                                  child: Builder(
                                                    builder: (context) {
                                                      int diviser = solidUnit ==
                                                              SolidUnit.kg
                                                          ? 1
                                                          : solidUnit ==
                                                                  SolidUnit.g
                                                              ? 1000
                                                              : 1000000;

                                                      IngredientType type =
                                                          recipe!
                                                              .ingredients[
                                                                  index3]
                                                              .type!;
                                                      String unitTest =
                                                          NumberUnit.unit
                                                              .toString()
                                                              .split('.')
                                                              .last;
                                                      double totalQty = recipe!
                                                              .ingredients[
                                                                  index3]
                                                              .quantity *
                                                          (quantity / diviser);
                                                      if (type ==
                                                          IngredientType
                                                              .solid) {
                                                        unitTest = SolidUnit.g
                                                            .toString()
                                                            .split('.')
                                                            .last;

                                                        if (totalQty < 1) {
                                                          unitTest = SolidUnit
                                                              .mg
                                                              .toString()
                                                              .split('.')
                                                              .last;
                                                          totalQty =
                                                              totalQty * 1000;
                                                        } else if (totalQty >=
                                                            1000) {
                                                          unitTest = SolidUnit
                                                              .kg
                                                              .toString()
                                                              .split('.')
                                                              .last;
                                                          totalQty =
                                                              totalQty / 1000;
                                                        }
                                                      } else if (type ==
                                                          IngredientType
                                                              .liquid) {
                                                        unitTest = LiquidUnit.l
                                                            .toString()
                                                            .split('.')
                                                            .last;
                                                        if (totalQty < 1) {
                                                          unitTest = LiquidUnit
                                                              .ml
                                                              .toString()
                                                              .split('.')
                                                              .last;
                                                          totalQty =
                                                              totalQty * 1000;
                                                        } else if (totalQty >=
                                                            1000) {
                                                          unitTest = LiquidUnit
                                                              .kl
                                                              .toString()
                                                              .split('.')
                                                              .last;
                                                          totalQty =
                                                              totalQty / 1000;
                                                        }
                                                      }

                                                      return Text(
                                                        '${totalQty} ${unitTest}',
                                                        style: FluentTheme.of(
                                                                context)
                                                            .typography
                                                            .bodyStrong,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(2),
                                                  child: Text(
                                                    recipe!.ingredients[index3]
                                                        .name!,
                                                    style:
                                                        FluentTheme.of(context)
                                                            .typography
                                                            .body,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: FluentTheme.of(context).accentColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text('Preparation',
                                      style: FluentTheme.of(context)
                                          .typography
                                          .title),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: FluentTheme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children:
                                  List.generate(recipe!.steps.length, (index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'Step ${recipe!.steps[index].stepNumber}',
                                          style: FluentTheme.of(context)
                                              .typography
                                              .subtitle,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          recipe!.steps[index].description,
                                          style: FluentTheme.of(context)
                                              .typography
                                              .body,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          )
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
