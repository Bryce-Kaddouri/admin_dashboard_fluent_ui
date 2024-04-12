import 'package:admin_dashboard/src/feature/recipe/data/model/recipe_model.dart';
import 'package:admin_dashboard/src/feature/recipe/presentation/provider/recipe_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:units_converter/units_converter.dart';

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
  Unit unit = Mass().kilograms;

  Unit getSelectedUnit(String unit) {
    switch (unit) {
      case 'kg':
        return Mass().kilograms;
      case 'g':
        return Mass().grams;
      case 'mg':
        return Mass().milligrams;
      default:
        return Mass().kilograms;
    }
  }

  String getUnitName(Unit unit) {
    if (unit == Mass().kilograms) {
      return 'kg';
    } else if (unit == Mass().grams) {
      return 'g';
    } else if (unit == Mass().milligrams) {
      return 'mg';
    } else {
      return 'kg';
    }
  }

  SolidUnit getSolidUnit(String unit) {
    switch (unit) {
      case 'kg':
        return SolidUnit.kg;
      case 'g':
        return SolidUnit.g;
      case 'mg':
        return SolidUnit.mg;

      case 'mg':
        return SolidUnit.mg;
      case 'g':
        return SolidUnit.g;
      case 'kg':
        return SolidUnit.kg;
      default:
        return SolidUnit.kg;
    }
  }

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

  int getDiffSolidUnit(SolidUnit from, SolidUnit to) {
    int fromIndex = from.index;
    int toIndex = to.index;
    return (fromIndex - toIndex) == 0 ? 1 : (fromIndex - toIndex);
  }

  double calculateQuantity(SolidUnit recipeUnit, int qtyRecipe, int qtyIng, {SolidUnit? unit, LiquidUnit? liquidUnit, NumberUnit? numberUnit}) {
    double res = 0;

    if (unit != null) {
      int diff = getDiffSolidUnit(recipeUnit, unit);
      if (diff > 0) {
        res = qtyIng * (1 / (10 ^ diff));
      } else {
        res = qtyIng * (10 ^ diff).toDouble();
      }
    }
    return res;
  }

  @override
  void initState() {
    super.initState();

    context.read<RecipeProvider>().getRecipeById(widget.id).then((value) {
      setState(() {
        print(value);
        recipe = value;
        isLoading = false;
      });
    });
    var kg = Mass()..convert(MASS.kilograms, 1);
    var g = kg.grams.value;
    print(g);
    print(Mass().getAll()); // 1 kg to grams
  }

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      backgroundColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
      appBar: material.AppBar(
        elevation: 4,
        shadowColor: FluentTheme.of(context).shadowColor,
        surfaceTintColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        backgroundColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        centerTitle: true,
        title: Text('Recipe Detail'),
        leading: material.BackButton(
          onPressed: () {
            context.go('/recipe');
          },
        ),
      ),
      body: Container(
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
                                                  color: FluentTheme.of(context).scaffoldBackgroundColor,
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
                                              min: 1,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              mode: SpinButtonPlacementMode.none,
                                              clearButton: false,
                                              textAlign: TextAlign.center,
                                              value: quantity,
                                              onTextChange: (value) {
                                                double val = double.tryParse(value!) ?? 1;
                                                setState(() {
                                                  quantity = val;
                                                });
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  quantity = value!;
                                                });
                                              },
                                              style: FluentTheme.of(context).typography.bodyStrong!.copyWith(fontSize: 20),
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
                                                  color: FluentTheme.of(context).scaffoldBackgroundColor,
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
                                      items: SolidUnit.values
                                          .map((e) => ComboBoxItem<SolidUnit>(
                                                child: Text(e.name),
                                                value: e,
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          solidUnit = SolidUnit.values.firstWhere((element) => element == value);
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
                                      icon: Icon(
                                        FluentIcons.view_all2,
                                        size: 24,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                      icon: Icon(
                                        FluentIcons.thumbnail_view,
                                        size: 24,
                                      ),
                                      onPressed: () {},
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
                                child: Text('Ingredients', style: FluentTheme.of(context).typography.title),
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
                              double nbItemPerRow = constraints.maxWidth / 120;
                              int nbRow = (recipe!.ingredients.length / nbItemPerRow).ceil();

                              return Column(
                                children: List.generate(nbRow, (index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: List.generate(nbItemPerRow.toInt(), (index2) {
                                        int index3 = index * nbItemPerRow.toInt() + index2;
                                        if (index3 >= recipe!.ingredients.length) {
                                          return Expanded(child: Container());
                                        }
                                        return Expanded(
                                          child: Column(
                                            children: [
                                              Card(
                                                child: Container(
                                                  height: 80,
                                                  width: 80,
                                                  child: Image(
                                                    image: NetworkImage(recipe!.ingredients[index3].photoUrl ?? ''),
                                                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                                      if (wasSynchronouslyLoaded) {
                                                        return child;
                                                      }
                                                      return AnimatedOpacity(
                                                        child: child,
                                                        opacity: frame == null ? 0 : 1,
                                                        duration: const Duration(seconds: 1),
                                                        curve: Curves.easeOut,
                                                      );
                                                    },
                                                    loadingBuilder: (context, child, loadingProgress) {
                                                      if (loadingProgress == null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child: ProgressRing(
                                                          value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                        ),
                                                      );
                                                    },
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Container(child: Icon(FluentIcons.cake));
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                child: Builder(
                                                  builder: (context) {
                                                    MASS kg = MASS.kilograms;
                                                    if (unit == Mass().kilograms) {
                                                      kg = MASS.kilograms;
                                                    } else if (unit == Mass().grams) {
                                                      kg = MASS.grams;
                                                    } else if (unit == Mass().milligrams) {
                                                      kg = MASS.milligrams;
                                                    }

                                                    return Text(
                                                      '${(recipe!.ingredients[index3].quantity * quantity)} ${RecipeIngredientModel.getUnit(recipe!.ingredients[index3].quantity * quantity, recipe!.ingredients[index3].type!)}',
                                                      style: FluentTheme.of(context).typography.bodyStrong,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  recipe!.ingredients[index3].name!,
                                                  style: FluentTheme.of(context).typography.body,
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
                                child: Text('Preparation', style: FluentTheme.of(context).typography.title),
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
                            children: List.generate(recipe!.steps.length, (index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Step ${recipe!.steps[index].stepNumber}',
                                        style: FluentTheme.of(context).typography.subtitle,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        recipe!.steps[index].description,
                                        style: FluentTheme.of(context).typography.body,
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
    );
  }
}
