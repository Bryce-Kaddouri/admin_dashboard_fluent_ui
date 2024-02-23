import 'dart:typed_data';

import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';
import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';
import 'package:admin_dashboard/src/feature/product/presentation/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../category/presentation/category_provider/category_provider.dart';

class UpdateProductScreen extends StatelessWidget {
  final int productId;
  UpdateProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            onPressed: () {
/*
              RouterHelper.back();
*/
              context.go('/product-list');
            },
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text('Update Product'),
        ),
        body: FutureBuilder(
          future: Future.wait([
            context.read<ProductProvider>().getProductById(productId),
            context.read<CategoryProvider>().getCategoriesAsync(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('data');
              print(snapshot.data);
              ProductModel productModel = snapshot.data![0] as ProductModel;
              List<CategoryModel> categories = snapshot.data![1] as List<CategoryModel>;
              print(categories);
              print( productModel
                  .categoryId);
              return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: UpdateProductForm(
                    productModel: productModel,
                    categories: categories,
                  ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class UpdateProductForm extends StatelessWidget {
  final ProductModel productModel;
  List<CategoryModel> categories;
  UpdateProductForm({super.key, required this.productModel, required this.categories});

  // global key for the form
  final _formKey = GlobalKey<FormBuilderState>();

  String imgUrl = '';


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        child: Column(
          children: [

            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderField<Uint8List>(
                      builder: (FormFieldState<Uint8List> field) {
                        return Column(
                          children: [
                            Text('Image'),
                            if (field.value != null)
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
                                    field.value!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                height: 200,
                                width: 200,
                                child: imgUrl.isEmpty
                                    ? Icon(Icons.image)
                                    : Image(
                                  image: NetworkImage(imgUrl),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            const SizedBox(height: 10),
                            MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              minWidth: 200,
                              height: 50,
                              onPressed: () async {
                                XFile? result = await context
                                    .read<ProductProvider>()
                                    .pickImage();
                                if (result != null) {
                                  Uint8List bytes = await result.readAsBytes();
                                  field.didChange(bytes);
                                }
                              },
                              child: Text(field.value != null
                                  ? 'Change Image'
                                  : 'Pick Image'),
                            ),
                          ],
                        );
                      },
                      name: 'image',
                      initialValue: null,
                      validator: FormBuilderValidators.compose([

                      ])),
                  SizedBox(height: 40),
                  FormBuilderTextField(
                    initialValue:
                     productModel
                        .name,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    name: 'name',
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Burger',
                      hintStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: 500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      label: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Name',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            children: [
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blueAccent,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  SizedBox(height: 40),
                  FormBuilderTextField(
                    initialValue:
                    productModel
                        .price
                        .toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    name: 'price',
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '3.60',
                      hintStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: 500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      label: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Price',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            children: [
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blueAccent,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  FormBuilderTextField(
                    initialValue:
                   productModel
                        .description,
                    name: 'description',
                    maxLines: 5,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Description of the product ...',
                      hintStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: 500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      label: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Description',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blueAccent,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([]),
                  ),
                  SizedBox(height: 40),

                  
                  FormBuilderDropdown<int>(
                    initialValue:
                    productModel
                        .categoryId,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '-- Select Category --',
                      hintStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: 500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      label: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Category',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            children: [
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blueAccent,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    name: 'category_id',
                    items: List.generate(
                      categories.length,
                          (index) => DropdownMenuItem(
                        child: Row(
                          children: [
                            Text(
                                '${categories[index].id} - '),
                            Expanded(
                              child: Container(
                                child: Text(categories[index]
                                    .name),
                              ),
                            ),
                          ],
                        ),
                        value: categories[index]
                            .id,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              minWidth: 500,
              height: 50,
              onPressed: () async {
                if (_formKey.currentState!.saveAndValidate()) {

                    print('update');
                    print(_formKey.currentState!.value);
                    String name = _formKey.currentState!.value['name'];
                    String? description =
                    _formKey.currentState!.value['description'];
                    double price = double.parse(
                        _formKey.currentState!.value['price'].toString());
                    print(price);

                    Uint8List? image = _formKey.currentState!.value['image'];
                    int categoryId =
                    _formKey.currentState!.value['category_id'];

                    ProductModel initialProductModel =
                    productModel;
                    ProductModel newProductModel = initialProductModel;

                    if (name == initialProductModel.name &&
                        description == initialProductModel.description &&
                        image == null &&
                        price == initialProductModel.price &&
                        categoryId == initialProductModel.categoryId) {
                      print('no changes');
                      Get.snackbar(
                        'Error',
                        'No changes made',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 3),
                        icon: const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                        ),
                        isDismissible: true,
                        forwardAnimationCurve: Curves.easeOutBack,
                        reverseAnimationCurve: Curves.easeInBack,
                        onTap: (value) => Get.back(),
                        mainButton: TextButton(
                          onPressed: () => Get.back(),
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      print('changes made');
                      if (image == null) {
                        print('no image');
                        if (name != newProductModel.name) {
                          print('name changed');
                          newProductModel =
                              newProductModel.copyWith(name: name);
                        } else if (description != newProductModel.description) {
                          print('description changed');
                          newProductModel = newProductModel.copyWith(
                              description: description);
                        } else if (price != newProductModel.price) {
                          print('price changed');
                          newProductModel =
                              newProductModel.copyWith(price: price);
                        } else if (categoryId != newProductModel.categoryId) {
                          newProductModel = newProductModel.copyWith(
                            categoryId: categoryId,
                          );
                        }
                      } else {
                        print('image changed');
                        String? imageUrl = await context
                            .read<ProductProvider>()
                            .uploadImage(image);
                        print(imageUrl);
                        if (imageUrl != null) {
                          print('image uploaded');
                          newProductModel =
                              newProductModel.copyWith(imageUrl: imageUrl);
                          if (name != newProductModel.name) {
                            print('name changed');
                            newProductModel =
                                newProductModel.copyWith(name: name);
                          } else if (description !=
                              newProductModel.description) {
                            print('description changed');
                            newProductModel = newProductModel.copyWith(
                                description: description);
                          } else if (price != newProductModel.price) {
                            newProductModel.copyWith(price: price);
                          } else if (categoryId != newProductModel.categoryId) {
                            newProductModel.copyWith(categoryId: categoryId);
                          }
                        } else {
                          Get.snackbar(
                            'Error',
                            'Error uploading image',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 3),
                            icon: const Icon(
                              Icons.error_outline,
                              color: Colors.white,
                            ),
                            isDismissible: true,
                            forwardAnimationCurve: Curves.easeOutBack,
                            reverseAnimationCurve: Curves.easeInBack,
                            onTap: (value) => Get.back(),
                            mainButton: TextButton(
                              onPressed: () => Get.back(),
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      }
                      print('test datas');
                      print(newProductModel.toJson());
                      ProductModel? updateRes = await context
                          .read<ProductProvider>()
                          .updateProduct(newProductModel);
                      if (updateRes != null) {
                        print('success');
                        Get.snackbar(
                          'Success',
                          'Product updated successfully',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                          isDismissible: true,
                          forwardAnimationCurve: Curves.easeOutBack,
                          reverseAnimationCurve: Curves.easeInBack,
                          onTap: (value) => Get.back(),
                          mainButton: TextButton(
                            onPressed: () => Get.back(),
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                       /* widget.pageController.animateToPage(
                          6,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );*/
                      } else {
                        print('failed');
                        Get.snackbar(
                          'Error',
                          'Error updating product',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(
                            Icons.error_outline,
                            color: Colors.white,
                          ),
                          isDismissible: true,
                          forwardAnimationCurve: Curves.easeOutBack,
                          reverseAnimationCurve: Curves.easeInBack,
                          onTap: (value) => Get.back(),
                          mainButton: TextButton(
                            onPressed: () => Get.back(),
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                      print(newProductModel.toJson());
                    }

                } else {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.value['image'] == null) {
                    Get.snackbar(
                      'Error',
                      'Please pick an image',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      snackPosition: SnackPosition.TOP,
                      duration: const Duration(seconds: 3),
                      icon: const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      ),
                      isDismissible: true,
                      forwardAnimationCurve: Curves.easeOutBack,
                      reverseAnimationCurve: Curves.easeInBack,
                      onTap: (value) => Get.back(),
                      mainButton: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                }
              },
              child: context.watch<ProductProvider>().isLoading
                  ? const CircularProgressIndicator(
                color: Colors.white,
              )
                  : Text('Submit'),
            ),
            SizedBox(height: 100),
          ],
        ),

    );
  }
}

