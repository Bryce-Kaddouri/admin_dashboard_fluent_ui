import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../category/data/model/category_model.dart';
import '../../data/model/product_model.dart';
import '../provider/product_provider.dart';

// add catgeory screen
// name, description, image

class UpdateProductScreen extends StatelessWidget {
  final int productId;
  UpdateProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      backgroundColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,

      /* padding: EdgeInsets.zero,
      header: Container(
        color:
            FluentTheme.of(context).navigationPaneTheme.overlayBackgroundColor,
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(width: 10),
            IconButton(
              icon: Icon(FluentIcons.back, size: 20),
              onPressed: () {
                context.go('/product');
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text('Update Product', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),*/
      appBar: material.AppBar(
        elevation: 4,
        shadowColor: FluentTheme.of(context).shadowColor,
        surfaceTintColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        backgroundColor: FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        centerTitle: true,
        title: Text('Update Product'),
        leading: material.BackButton(
          onPressed: () {
            context.go('/product');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height - 60,
          ),
          child: ProductUpdateForm(id: productId),
        ),
      ),
    );
  }
}

class ProductUpdateForm extends StatefulWidget {
  int id;
  ProductUpdateForm({super.key, required this.id});

  @override
  State<ProductUpdateForm> createState() => _ProductUpdateFormState();
}

class _ProductUpdateFormState extends State<ProductUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  String imageUrl = '';

  List<CategoryModel> lstCategory = [];
  CategoryModel? selectedObjectCategory;

  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getCategoriesAsync().then((value) {
      setState(() {
        lstCategory = value ?? [];
      });
    }).whenComplete(() {
      return context.read<ProductProvider>().getProductById(widget.id).then((ProductModel? value) {
        if (value != null) {
          setState(() {
            nameController.text = value.name;
            priceController.text = value.price.toString();
            descriptionController.text = value.description ?? '';
            categoryController.text = value.name;
            selectedObjectCategory = lstCategory.firstWhere(
              (element) => element.id == value.categoryId,
            );
            imageUrl = value.imageUrl;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(context.watch<ProductProvider>().productModel);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 50),

          InfoLabel(
            label: 'Add product image:',
            child: Column(
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
                else if (imageUrl.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 200,
                    width: 200,
                    clipBehavior: Clip.antiAlias,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        imageUrl,
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
                SizedBox(height: 10),
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
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 30,
                    child: Text(image != null ? 'Change Image' : 'Pick Image'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),

          InfoLabel(
            label: 'Enter product name:',
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
          SizedBox(height: 50),

          InfoLabel(
            label: 'Enter product price:',
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 500, maxHeight: 50),
              child: NumberFormBox<double>(
                precision: 2,
                value: priceController.text.isEmpty ? null : double.parse(priceController.text),
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
          ),
          SizedBox(height: 50),

          InfoLabel(
            label: 'Enter product description:',
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 500, maxHeight: 50),
              child: TextFormBox(
                controller: descriptionController,
                placeholder: 'Description',
              ),
            ),
          ),

          // auto suggest category
          SizedBox(height: 50),

          InfoLabel(
            label: 'Select category:',
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 500, maxHeight: 50),
              child: AutoSuggestBox.form(
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
          ),
          SizedBox(height: 100),

          FilledButton(
              child: context.watch<ProductProvider>().isLoading
                  ? ProgressRing()
                  : Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 30,
                      child: Text('Update Product'),
                    ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print('Form is valid');
                  String name = nameController.text;
                  String description = descriptionController.text;
                  String? imageUrl;
                  double price = double.parse(priceController.text);
                  int categoryId = selectedObjectCategory!.id;

                  if (imageUrl != null) {
                    String? imageUrl = await context.read<ProductProvider>().uploadImage(image!);
                    ProductModel? oldProduct = await context.read<ProductProvider>().getProductById(widget.id);
                    ProductModel newProduct = ProductModel(
                      id: oldProduct!.id,
                      name: oldProduct.name != name ? name : oldProduct.name,
                      description: oldProduct.description != description ? description : oldProduct.description,
                      imageUrl: oldProduct.imageUrl != imageUrl ? imageUrl ?? oldProduct.imageUrl : oldProduct.imageUrl,
                      createdAt: oldProduct.createdAt,
                      updatedAt: DateTime.now(),
                      isVisible: oldProduct.isVisible,
                      price: oldProduct.price != price ? price : oldProduct.price,
                      categoryId: oldProduct.categoryId != categoryId ? categoryId : oldProduct.categoryId,
                    );
                    bool res = await context.read<ProductProvider>().updateProduct(newProduct, context);
                  } else {
                    ProductModel? oldProduct = await context.read<ProductProvider>().getProductById(widget.id);
                    ProductModel newProduct = ProductModel(
                      id: oldProduct!.id,
                      name: oldProduct.name != name ? name : oldProduct.name,
                      description: oldProduct.description != description ? description : oldProduct.description,
                      imageUrl: oldProduct.imageUrl != imageUrl ? imageUrl ?? oldProduct.imageUrl : oldProduct.imageUrl,
                      createdAt: oldProduct.createdAt,
                      updatedAt: DateTime.now(),
                      isVisible: oldProduct.isVisible,
                      price: oldProduct.price != price ? price : oldProduct.price,
                      categoryId: oldProduct.categoryId != categoryId ? categoryId : oldProduct.categoryId,
                    );
                    bool res = await context.read<ProductProvider>().updateProduct(newProduct, context);
                  }
                  // reset form
                  /*  nameController.clear();
                          descriptionController.clear();
                          priceController.clear();
                          categoryController.clear();
                          setState(() {
                            image = null;
                          });*/
                } else {
                  print('Form is invalid');
                }
              }),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
