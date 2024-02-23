import 'dart:io';

import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../category/data/model/category_model.dart';
import '../../data/model/product_model.dart';
import '../provider/product_provider.dart';

// add catgeory screen
// name, description, image

class ProductAddScreen extends StatefulWidget {

  ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController(
    text: '1.50',
  );
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  List<CategoryModel> lstCategory = [];
  CategoryModel? selectedObjectCategory;

  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getCategoriesAsync().then((value) {
      setState(() {
        lstCategory = value ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(context.watch<ProductProvider>().productModel);

    return SingleChildScrollView(
      child: Container(
        child:
        Form(
          key: _formKey,
          child:
        Column(
          children: [
        InfoLabel(
        label: 'Add product image:',
        child:
        Column(
                    children: [

                      if (image != null)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 200,
                          width: 200,
                          clipBehavior: Clip.antiAlias,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.memory(
                              image!,
                              fit: BoxFit.fill,
                            ),
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
                      FilledButton(
                        onPressed: () async {
                          XFile? result = await context.read<CategoryProvider>().pickImage();
                          if (result != null) {
                            Uint8List bytes = await result.readAsBytes();
                            setState(() {
                              image = bytes;
                            });
                          }
                        },
                        child: Text(image != null ? 'Change Image' : 'Pick Image'),
                      ),
                    ],),
        ),
            InfoLabel(
              label: 'Enter product name:',
              child:
              TextFormBox(
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
          InfoLabel(
            label: 'Enter product price:',
            child:
            NumberFormBox<double>(
              precision: 2,
              value: double.parse(priceController.text),

              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d+\.?\d{0,2}'),
                ),
              ],
              min: 0,
              onChanged: (value) {
                priceController.text = value.toString();
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
              ]),
              placeholder: 'Price',
              smallChange: 0.1,
              largeChange: 1,
              mode: SpinButtonPlacementMode.inline,
            ),
          ),
            InfoLabel(
              label: 'Enter product description:',
              child:
              TextFormBox(
                controller: descriptionController,
                placeholder: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product description';
                  }
                  return null;
                },
              ),
            ),

            // auto suggest category
          InfoLabel(
            label: 'Select category:',
            child:
            AutoSuggestBox.form(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Please select category'),
              ]),
              controller: categoryController,
              placeholder: 'Select Category',
              items: lstCategory
                  .map<AutoSuggestBoxItem<CategoryModel>>(
                    (cat) => AutoSuggestBoxItem<CategoryModel>(
                  value: cat,
                  label: cat.name,
                  onFocusChange: (focused) {
                    if (focused) {
                      debugPrint('Focused #${cat.id} - ${cat.name}');
                    }
                  },
                ),
              )
                  .toList(),
              onSelected: (item) {
                setState(() {
                  selectedObjectCategory = item.value;
                  categoryController.text = item.value!.id.toString();

                });
              },
            ),
          ),
            FilledButton(child: Text('Submit'), onPressed: () async {
              if (_formKey.currentState!.validate()) {
                print('Form is valid');
                String name = nameController.text;
                String description = descriptionController.text;
                String imageUrl = '';
                double price = double.parse(priceController.text);
                int categoryId = selectedObjectCategory!.id;
                context.read<ProductProvider>().addProduct(name, description, imageUrl, price, categoryId);
               /* ProductModel productModel = ProductModel(
                  name: nameController.text,
                  price: double.parse(priceController.text),
                  description: descriptionController.text,
                  categoryId: selectedObjectCategory!.id,
                  imageUrl: '',
                );
                bool isSuccess = await context.read<ProductProvider>().addProduct(productModel, image!);
                if (isSuccess) {
                  Get.snackbar('Success', 'Product has been added');
                } else {
                  Get.snackbar('Error', 'Product has not been added');
                }*/

              }else{
                print('Form is invalid');
              }
            }
            ),

          ],
        ),
        ),
      ),
    );
  }
}
