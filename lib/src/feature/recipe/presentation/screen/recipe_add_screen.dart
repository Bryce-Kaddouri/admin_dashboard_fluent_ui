import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:admin_dashboard/src/feature/ingredient/presentation/provider/ingredient_provider.dart';
import 'package:admin_dashboard/src/feature/recipe/presentation/provider/recipe_provider.dart';
import 'package:cropperx/cropperx.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/model/recipe_model.dart';

// add catgeory screen
// name, description, image

class RecipeAddScreen extends StatefulWidget {
  const RecipeAddScreen({super.key});

  @override
  State<RecipeAddScreen> createState() => _RecipeAddScreenState();
}

class _RecipeAddScreenState extends State<RecipeAddScreen> {
  final _formKey = GlobalKey<FormState>();

  // controller for name
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController stepController = TextEditingController();

  Uint8List? image;
  final _cropperKey = GlobalKey(debugLabel: 'cropperKey');
  IngredientModel? selectedIngredient;
  double? quantity;
  String? unit;

  @override
  void initState() {
    super.initState();
    context.read<IngredientProvider>().getIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                InfoLabel(
                  label: 'Enter recipe name:',
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 500, maxHeight: 50),
                    child: TextFormBox(
                      controller: nameController,
                      placeholder: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter category name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text('Image'),
                    SizedBox(height: 10),
                    if (image != null)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 500,
                        width: 500,
                        clipBehavior: Clip.antiAlias,
                        child: Cropper(
                          zoomScale: 2,
                          overlayType: OverlayType.grid,
                          cropperKey: _cropperKey, // Use your key here
                          image: Image.memory(image!),
                        ),
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        height: 200,
                        width: 200,
                        child: Icon(FluentIcons.photo2_add),
                      ),
                    SizedBox(height: 10),
                    FilledButton(
                      onPressed: () async {
                        XFile? result = await context.read<CategoryProvider>().pickImage(context);
                        if (result != null) {
                          Uint8List bytes = await result.readAsBytes();
                          setState(() {
                            image = bytes;
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 30,
                        child: Text(image != null ? 'Change Image' : 'Pick Image'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                InfoLabel(
                  label: 'Enter recipe description:',
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 500),
                    child: TextFormBox(
                      controller: descriptionController,
                      placeholder: 'Description',
                      maxLines: 8,
                      minLines: 2,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                InfoLabel(
                  label: 'Select ingredient:',
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 500),
                    child: ComboboxFormField<IngredientModel>(
                      value: selectedIngredient,
                      isExpanded: true,
                      placeholder: Text('-- Select ingredient --'),
                      items: context.read<IngredientProvider>().ingredients.map((e) => ComboBoxItem<IngredientModel>(value: e, child: Text(e.name))).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedIngredient = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select ingredient';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                if (selectedIngredient != null)
                  InfoLabel(
                    label: 'Enter quantity:',
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 500),
                      child: NumberFormBox(
                        value: quantity,
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter quantity';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            quantity = value;
                          });
                        },
                      ),
                    ),
                  ),
                if (selectedIngredient != null)
                  InfoLabel(
                    label: 'Select ingredient type:',
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 500),
                      child: ComboboxFormField<String>(
                        value: unit,
                        isExpanded: true,
                        placeholder: Text('-- Select ingredient unit --'),
                        items: IngredientUnitImpl.getUnits(selectedIngredient!.type).map((e) => ComboBoxItem<String>(value: e, child: Text(e))).toList(),
                        onChanged: (value) {
                          setState(() {
                            unit = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select ingredient unit';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                if (selectedIngredient != null && unit != null && quantity != null)
                  Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 500),
                    child: FilledButton(
                        onPressed: () {
                          // add ingredient
                          print('add ingredient');
                          RecipeIngredientModel ingredient = RecipeIngredientModel(
                            ingredientId: selectedIngredient!.id,
                            name: selectedIngredient!.name,
                            photoUrl: selectedIngredient!.photoUrl,
                            quantity: quantity!,
                            unit: unit!,
                          );
                          // add ingredient to recipe
                          context.read<RecipeProvider>().addDraft(ingredient);
                          setState(() {
                            selectedIngredient = null;
                            unit = null;
                            quantity = null;
                          });
                        },
                        child: Text('Add ingredient')),
                  ),
                const SizedBox(height: 50),
                if (context.watch<RecipeProvider>().draftList.isNotEmpty)
                  Column(
                    children: [
                      Text('Ingredients'),
                      SizedBox(height: 10),
                      Container(
                        constraints: BoxConstraints(maxWidth: 500),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: context.watch<RecipeProvider>().draftList.length,
                          itemBuilder: (context, index) {
                            RecipeIngredientModel ingredient = context.watch<RecipeProvider>().draftList[index];
                            return ListTile(
                              leading: ingredient.photoUrl != null
                                  ? Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(ingredient.photoUrl!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      /* child: ClipRect(
                                        child: Image.network(
                                          fit: BoxFit.cover,
                                          ingredient.photoUrl!,
                                          errorBuilder: (context, obj, trace) {
                                            return Icon(FluentIcons.reservation_orders);
                                          },
                                        ), //
                                      ), */ // Image.network(ingredient.photoUrl!),
                                    )
                                  : Icon(FluentIcons.reservation_orders),
                              title: Text(ingredient.name ?? ''),
                              subtitle: Text('${ingredient.quantity} ${ingredient.unit}'),
                              trailing: IconButton(
                                icon: Icon(FluentIcons.delete),
                                onPressed: () {
                                  RecipeIngredientModel ingredient = context.read<RecipeProvider>().draftList[index];
                                  context.read<RecipeProvider>().removeDraft(ingredient);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 50),
                InfoLabel(
                  label: 'Step ${context.watch<RecipeProvider>().draftSteps.length + 1} \n\nEnter step description:',
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 500),
                    child: TextFormBox(
                      controller: stepController,
                      placeholder: 'Description',
                      maxLines: 8,
                      minLines: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                FilledButton(
                    child: Text('Add Step'),
                    onPressed: () {
                      // add step
                      print('add step');
                      RecipeStepModel step = RecipeStepModel(description: stepController.text, stepNumber: context.read<RecipeProvider>().draftSteps.length + 1);
                      context.read<RecipeProvider>().addDraftStep(step);
                      stepController.clear();
                    }),
                if (context.watch<RecipeProvider>().draftSteps.isNotEmpty)
                  Column(
                    children: List.generate(
                      context.watch<RecipeProvider>().draftSteps.length,
                      (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              constraints: BoxConstraints(maxWidth: 500),
                              child: Text('Step ${index + 1}', style: FluentTheme.of(context).typography.subtitle!.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 10),
                            Container(
                              constraints: BoxConstraints(maxWidth: 500),
                              child: Row(children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(context.watch<RecipeProvider>().draftSteps[index].description),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(FluentIcons.delete),
                                  onPressed: () {
                                    RecipeIngredientModel ingredient = context.read<RecipeProvider>().draftList[index];
                                    context.read<RecipeProvider>().removeDraft(ingredient);
                                  },
                                ),
                              ]),
                            ),
                            const SizedBox(height: 50),
                          ],
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 100),
                FilledButton(
                    child: context.watch<CategoryProvider>().isLoading ? const ProgressRing() : Container(alignment: Alignment.center, width: 200, height: 30, child: const Text('Add Category')),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print('add category');
                        String name = nameController.text;
                        String description = descriptionController.text;
                        // upload image
                        if (image != null) {
                          final imageBytes = await Cropper.crop(
                            cropperKey: _cropperKey, // Reference it through the key
                          );
                          String? imageUrl = await context.read<CategoryProvider>().uploadImage(imageBytes!);
                          if (imageUrl != null) {
/*
                            IngredientModel ingredient = IngredientModel(name: name, photoUrl: imageUrl, id: 0, createdAt: DateTime.now(), type: selectedType!);
*/
                            bool res = true /*await context.read<IngredientProvider>().addIngredient(ingredient)*/;
                            if (res) {
                              nameController.clear();
                              descriptionController.clear();
                              setState(() {
                                image = null;
                              });
                              await displayInfoBar(
                                context,
                                builder: (context, close) {
                                  return InfoBar(
                                    title: Text('Ingredient added successfully'),
                                    severity: InfoBarSeverity.success,
                                    isLong: false,
                                    style: InfoBarThemeData.standard(FluentTheme.of(context)),
                                    onClose: close,
                                  );
                                },
                                alignment: Alignment.topRight,
                              );
                            } else {
                              await displayInfoBar(
                                context,
                                builder: (context, close) {
                                  return InfoBar(
                                    title: Text('Ingredient added failed'),
                                    severity: InfoBarSeverity.error,
                                    isLong: false,
                                    style: InfoBarThemeData.standard(FluentTheme.of(context)),
                                    onClose: close,
                                  );
                                },
                                alignment: Alignment.topRight,
                              );
                            }
                          }
                        } else {
/*
                          IngredientModel ingredient = IngredientModel(name: name, photoUrl: null, id: 0, createdAt: DateTime.now(), type: selectedType!);
*/
                          bool res = true; /*await context.read<IngredientProvider>().addIngredient(ingredient);*/
                          if (res) {
                            nameController.clear();
                            descriptionController.clear();
                            setState(() {
                              image = null;
                            });
                            await displayInfoBar(
                              context,
                              builder: (context, close) {
                                return InfoBar(
                                  title: Text('Ingredient added successfully'),
                                  severity: InfoBarSeverity.success,
                                  isLong: false,
                                  style: InfoBarThemeData.standard(FluentTheme.of(context)),
                                  onClose: close,
                                );
                              },
                              alignment: Alignment.topRight,
                            );
                          } else {
                            await displayInfoBar(
                              context,
                              builder: (context, close) {
                                return InfoBar(
                                  title: Text('Ingredient added failed'),
                                  severity: InfoBarSeverity.error,
                                  isLong: false,
                                  style: InfoBarThemeData.standard(FluentTheme.of(context)),
                                  onClose: close,
                                );
                              },
                              alignment: Alignment.topRight,
                            );
                          }
                        }
                      } else {
                        print('form is not valid');
                      }
                    }),
              ],
            ),
          ),
        ])));
  }
}
