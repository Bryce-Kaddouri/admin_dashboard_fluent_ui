import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// add catgeory screen
// name, description, image

class CustomerAddScreen extends StatefulWidget {
  const CustomerAddScreen({super.key});

  @override
  State<CustomerAddScreen> createState() => _CustomerAddScreenState();
}

class _CustomerAddScreenState extends State<CustomerAddScreen> {
  final _formKey = GlobalKey<FormState>();

  // controller for name
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
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
                              child: Icon(FluentIcons.photo2_add),
                            ),
                          SizedBox(height: 10),
                          FilledButton(
                            onPressed: () async {
                              XFile? result = await context
                                  .read<CategoryProvider>()
                                  .pickImage();
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
                              child: Text(image != null
                                  ? 'Change Image'
                                  : 'Pick Image'),
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
                    child: context.watch<CategoryProvider>().isLoading
                        ? const ProgressRing()
                        : Container(
                            alignment: Alignment.center,
                            width: 200,
                            height: 30,
                            child: const Text('Add Category')),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print('add category');
                        String name = nameController.text;
                        String description = descriptionController.text;
                        // upload image
                        if (image != null) {
                          String? imageUrl = await context
                              .read<CategoryProvider>()
                              .uploadImage(image!);
                          if (imageUrl != null) {
                            bool res = await context
                                .read<CategoryProvider>()
                                .addCategory(
                                    name, description, imageUrl, context);
                            if (res) {
                              nameController.clear();
                              descriptionController.clear();
                              setState(() {
                                image = null;
                              });
                            }
                          }
                        } else {
                          bool res = await context
                              .read<CategoryProvider>()
                              .addCategory(name, description, '', context);
                          if (res) {
                            nameController.clear();
                            descriptionController.clear();
                            setState(() {
                              image = null;
                            });
                          }
                        }
                      } else {
                        print('form is not valid');
                      }
                    }),
              ],
            ),
          ),
        ]));
  }
}
