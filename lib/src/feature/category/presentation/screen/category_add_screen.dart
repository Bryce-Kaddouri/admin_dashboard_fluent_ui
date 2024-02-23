import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// add catgeory screen
// name, description, image

class CategoryAddScreen extends StatefulWidget {

  CategoryAddScreen({super.key});

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  final _formKey = GlobalKey<FormState>();

  // controller for name
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                FormField<Uint8List>(
                  initialValue: image,
                    validator: (value) {
                      if (value == null) {
                        return 'Please pick an image';
                      }
                      return null;
                    },
                    builder: (FormFieldState field) {
                  return Column(
                    children: [

                      Text('Image'),
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
                    ],);
                }),


                          /*MaterialButton(
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
                          ),*/








            InfoLabel(
              label: 'Enter category name:',
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
                  label: 'Enter category description:',
                  child: TextFormBox(
                    controller: descriptionController,
                    placeholder: 'Description',
                    expands: false,
                      maxLines: null,
                  ),
                ),
          const SizedBox(height: 100),
          /*MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            minWidth: 500,
            height: 50,
            onPressed: () async {
              if (_formKey.currentState!.saveAndValidate()) {
                print(_formKey.currentState!.value);
                String name = _formKey.currentState!.value['name'];
                String? description = _formKey.currentState!.value['description'];

                Uint8List image = _formKey.currentState!.value['image'];
                String? imageUrl = await context.read<CategoryProvider>().uploadImage(image);
                print(imageUrl);
                if (imageUrl != null) {
                  bool res = await context.read<CategoryProvider>().addCategory(name, description, imageUrl);
                  if (res) {

                    Get.snackbar(
                      'Success',
                      'Category added successfully',
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
                  } else {
                    Get.snackbar(
                      'Error',
                      'Error adding category',
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

                *//* bool res = await context
                    .read<CategoryProvider>()
                    .addCategory(name, description, 'image');
                if (res) {
                  print('success');
                } else {
                  print('failed');
                }*//*
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
            child: context.watch<CategoryProvider>().isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text('Submit'),
          ),*/

    FilledButton(child: context.watch<CategoryProvider>().isLoading ? const ProgressRing() : Text('Submit'), onPressed: () async {
      if(_formKey.currentState!.validate()){
        String name = nameController.text;
        String description = descriptionController.text;
        // upload image
        if(image != null){
          String? imageUrl = await context.read<CategoryProvider>().uploadImage(image!);
          if(imageUrl != null){
            bool res = await context.read<CategoryProvider>().addCategory(name, description, imageUrl);
          }
        } else {
          bool res = await context.read<CategoryProvider>().addCategory(name, description, '');
        }
      }

    }),



        ],
      ),
      ),
])
    );
  }
}
