import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/model/category_model.dart';
import '../category_provider/category_provider.dart';

class UpdateCategoryScreen extends StatelessWidget {
  final int categoryId;
  UpdateCategoryScreen({super.key, required this.categoryId});

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
              context.go('/category-list');
            },
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text('Update Category'),
        ),
        body: FutureBuilder(
          future: context.read<CategoryProvider>().getCategoryById(categoryId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('data');
              print(snapshot.data);
              CategoryModel categoryModel = snapshot.data as CategoryModel;
              return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: UpdateCategoryForm(
                    categoryModel: categoryModel,
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

class UpdateCategoryForm extends StatelessWidget {
  CategoryModel categoryModel;
  UpdateCategoryForm({super.key, required this.categoryModel});

  final _formKey = GlobalKey<FormBuilderState>();

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
                FormBuilderField<Uint8List?>(
                  builder: (FormFieldState<Uint8List?> field) {
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
                            /*child:
                                    FutureBuilder(
                                        future: context
                                            .read<CategoryProvider>()
                                            .getSignedUrl(context
                                                .read<CategoryProvider>()
                                                .categoryModel!
                                                .imageUrl!),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Image.network(
                                              snapshot.data as String,
                                              fit: BoxFit.fill,
                                              errorBuilder:
                                                  (context, error, stack) =>
                                                      Icon(Icons.image),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Icon(Icons.error);
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        })*/
                          ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          color: Theme.of(context).colorScheme.secondary,
                          minWidth: 200,
                          height: 50,
                          onPressed: () async {
                            XFile? result = await context.read<CategoryProvider>().pickImage();
                            if (result != null) {
                              Uint8List bytes = await result.readAsBytes();
                              field.didChange(bytes);
                            }
                          },
                          child: Text(field.value != null ? 'Change Image' : 'Pick Image'),
                        ),
                      ],
                    );
                  },
                  name: 'image',
                  initialValue: null,
                ),
                SizedBox(height: 40),
                FormBuilderTextField(
                  initialValue: categoryModel.name,
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
                  initialValue: categoryModel.description ?? '',
                  name: 'description',
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Description of the category ...',
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
              ],
            ),
          ),
          const SizedBox(height: 100),
          MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            minWidth: 500,
            height: 50,
            onPressed: () async {
              print('update');
              if (_formKey.currentState!.saveAndValidate()) {
                print(_formKey.currentState!.value);
                String name = _formKey.currentState!.value['name'];
                String? description = _formKey.currentState!.value['description'];

                Uint8List? image = _formKey.currentState!.value['image'];

                CategoryModel initialCategoryModel = categoryModel;
                CategoryModel newCategoryModel = initialCategoryModel;

                if (name == initialCategoryModel.name && description == initialCategoryModel.description && image == null) {
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
                    if (name != newCategoryModel.name) {
                      print('name changed');
                      newCategoryModel = newCategoryModel.copyWith(name: name);
                    } else if (description != newCategoryModel.description) {
                      print('description changed');
                      newCategoryModel = newCategoryModel.copyWith(description: description);
                    }
                  } else {
                    print('image changed');
                    String? imageUrl = await context.read<CategoryProvider>().uploadImage(image);
                    print(imageUrl);
                    if (imageUrl != null) {
                      print('image uploaded');
                      newCategoryModel = newCategoryModel.copyWith(imageUrl: imageUrl);
                      if (name != newCategoryModel.name) {
                        print('name changed');
                        newCategoryModel = newCategoryModel.copyWith(name: name);
                      } else if (description != newCategoryModel.description) {
                        print('description changed');
                        newCategoryModel = newCategoryModel.copyWith(description: description);
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
                  print(newCategoryModel.toJson());
                  CategoryModel? updateRes = await context.read<CategoryProvider>().updateCategory(newCategoryModel);
                  if (updateRes != null) {
                    print('success');
                    Get.snackbar(
                      'Success',
                      'Category updated successfully',
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
                    /* pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );*/
                  } else {
                    print('failed');
                    Get.snackbar(
                      'Error',
                      'Error updating category',
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
                  print(newCategoryModel.toJson());
                }
              }
            },
            child: context.watch<CategoryProvider>().isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text('Submit'),
          ),
        ],
      ),
    );
  }
}
