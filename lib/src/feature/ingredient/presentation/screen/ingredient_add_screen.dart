import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:admin_dashboard/src/feature/ingredient/presentation/provider/ingredient_provider.dart';
import 'package:cropperx/cropperx.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// add catgeory screen
// name, description, image

class IngredientAddScreen extends StatefulWidget {
  const IngredientAddScreen({super.key});

  @override
  State<IngredientAddScreen> createState() => _IngredientAddScreenState();
}

class _IngredientAddScreenState extends State<IngredientAddScreen> {
  final _formKey = GlobalKey<FormState>();

  // controller for name
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  Uint8List? image;
  final _cropperKey = GlobalKey(debugLabel: 'cropperKey');

  IngredientType? selectedType;

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
                  label: 'Enter ingredient name:',
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
                  label: 'Select ingredient type:',
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 500, maxHeight: 50),
                    child: ComboboxFormField<IngredientType>(
                      value: selectedType,
                      isExpanded: true,
                      placeholder: Text('-- Select ingredient type --'),
                      items: IngredientType.values.map((e) => ComboBoxItem<IngredientType>(value: e, child: Text(e.toString().split('.').last))).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select ingredient type';
                        }
                        return null;
                      },
                    ),
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
                            IngredientModel ingredient = IngredientModel(name: name, photoUrl: imageUrl, id: 0, createdAt: DateTime.now(), type: selectedType!);
                            bool res = await context.read<IngredientProvider>().addIngredient(ingredient);
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
                          IngredientModel ingredient = IngredientModel(name: name, photoUrl: null, id: 0, createdAt: DateTime.now(), type: selectedType!);
                          bool res = await context.read<IngredientProvider>().addIngredient(ingredient);
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
