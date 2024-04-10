import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
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
    return material.Scaffold(
      /*header: Container(
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
                context.go('/category');
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text('Update Category', style: TextStyle(fontSize: 20)),
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
        title: Text('Update Category'),
        leading: material.BackButton(
          onPressed: () {
            context.go('/category');
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
          color: FluentTheme.of(context).navigationPaneTheme.overlayBackgroundColor,
          child: FutureBuilder(
            future: context.read<CategoryProvider>().getCategoryById(categoryId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('data');
                print(snapshot.data);
                CategoryModel categoryModel = snapshot.data as CategoryModel;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: UpdateCategoryForm(
                    categoryModel: categoryModel,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              } else {
                return Center(
                  child: ProgressRing(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class UpdateCategoryForm extends StatefulWidget {
  CategoryModel categoryModel;
  UpdateCategoryForm({super.key, required this.categoryModel});

  @override
  State<UpdateCategoryForm> createState() => _UpdateCategoryFormState();
}

class _UpdateCategoryFormState extends State<UpdateCategoryForm> {
  final _formKey = GlobalKey<FormState>();

  // controller for name
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Uint8List? image;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.categoryModel.name;
    descriptionController.text = widget.categoryModel.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormField<Uint8List>(
              initialValue: image,
              builder: (FormFieldState field) {
                return Column(
                  children: [
                    Text('Image'),
                    SizedBox(height: 10),
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
                          child: widget.categoryModel.imageUrl.isEmpty
                              ? Center(
                                  child: Text('No Image'),
                                )
                              : Image.network(
                                  widget.categoryModel.imageUrl,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text('Error'),
                                    );
                                  },
                                )),
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
                );
              }),
          SizedBox(height: 50),
          InfoLabel(
            label: 'Enter category name:',
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
            label: 'Enter category description:',
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 500, maxHeight: 50),
              child: TextFormBox(
                controller: descriptionController,
                placeholder: 'Description',
                expands: false,
                maxLines: null,
              ),
            ),
          ),
          const SizedBox(height: 100),
          FilledButton(
              child: context.watch<CategoryProvider>().isLoading ? const ProgressRing() : Container(alignment: Alignment.center, width: 200, height: 30, child: const Text('Update Category')),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print('add category');
                  String name = nameController.text;
                  String description = descriptionController.text;
                  // upload image
                  if (image != null) {
                    String? imageUrl = await context.read<CategoryProvider>().uploadImage(image!);
                    if (imageUrl != null) {
                      CategoryModel oldCategory = widget.categoryModel;
                      CategoryModel newCategory = CategoryModel(
                        id: oldCategory.id,
                        name: oldCategory.name != name ? name : oldCategory.name,
                        description: oldCategory.description != description ? description : oldCategory.description,
                        imageUrl: oldCategory.imageUrl != imageUrl ? imageUrl : oldCategory.imageUrl,
                        createdAt: oldCategory.createdAt,
                        updatedAt: DateTime.now(),
                        isVisible: oldCategory.isVisible,
                      );
                      bool res = await context.read<CategoryProvider>().updateCategory(newCategory, context);
                    }
                  } else {
                    CategoryModel oldCategory = widget.categoryModel;
                    CategoryModel newCategory = CategoryModel(
                      id: oldCategory.id,
                      name: oldCategory.name != name ? name : oldCategory.name,
                      description: oldCategory.description != description ? description : oldCategory.description,
                      imageUrl: oldCategory.imageUrl,
                      createdAt: oldCategory.createdAt,
                      updatedAt: DateTime.now(),
                      isVisible: oldCategory.isVisible,
                    );
                    bool res = await context.read<CategoryProvider>().updateCategory(newCategory, context);
                  }
                } else {
                  print('form is not valid');
                }
              }),
        ],
      ),
    );
  }
}
