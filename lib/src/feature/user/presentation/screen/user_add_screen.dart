import 'dart:io';

import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../category/data/model/category_model.dart';
import '../../data/model/user_model.dart';
import '../provider/user_provider.dart';

// add catgeory screen
// name, description, image

class UserAddScreen extends StatefulWidget {
  PageController pageController;

  UserAddScreen({super.key, required this.pageController});

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  /*
  String imgUrl = '';

  void _initData() async {
    context.read<CategoryProvider>().getCategories();
    print('initState');

    if (context.read<ProductProvider>().productModel != null) {
      String? imageUrl = await context.read<ProductProvider>().getSignedUrl(
          context
              .read<ProductProvider>()
              .productModel!
              .imageUrl
              .split('/')
              .last);

      setState(() {
        imgUrl = imageUrl!;
      });
    }
  }


   */

  @override
  Widget build(BuildContext context) {
/*
    print(context.watch<ProductProvider>().productModel);
*/

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text(
                context.watch<UserProvider>().selectedUser == null
                    ? 'Add User'
                    : 'Update User',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  FormBuilderTextField(
                    initialValue:
                        context.watch<UserProvider>().selectedUser == null
                            ? null
                            : context
                                .watch<UserProvider>()
                                .selectedUser!
                                .userMetadata!['fName'],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    name: 'f_name',
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'John',
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
                            text: 'First Name',
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
                        context.watch<UserProvider>().selectedUser == null
                            ? null
                            : context
                                .watch<UserProvider>()
                                .selectedUser!
                                .userMetadata!['lName'],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    name: 'l_name',
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'John',
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
                            text: 'Last Name',
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
                        context.watch<UserProvider>().selectedUser == null
                            ? null
                            : context.watch<UserProvider>().selectedUser!.email,
                    name: 'email',
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'john.doe@mail.ie',
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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  SizedBox(height: 40),
                  FormBuilderTextField(
                    controller: _passwordController,
                    initialValue: null,
                    name: 'password',
                    onChanged: (value) {
                      if (_confirmPasswordController.text != value) {
                        _formKey.currentState?.fields['confirm_password']
                            ?.invalidate('Passwords do not match');
                      } else {
                        _formKey.currentState?.fields['confirm_password']
                            ?.validate();
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'password',
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
                            text: 'Password',
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
                    validator: FormBuilderValidators.compose([
                      if (context.watch<UserProvider>().selectedUser == null)
                        FormBuilderValidators.required(),
                    ]),
                  ),
                  SizedBox(height: 40),
                  FormBuilderTextField(
                    controller: _confirmPasswordController,
                    initialValue: null,
                    name: 'confirm_password',
                    onChanged: (value) {
                      if (_passwordController.text != value) {
                        _formKey.currentState?.fields['confirm_password']
                            ?.invalidate('Passwords do not match');
                      } else {
                        _formKey.currentState?.fields['confirm_password']
                            ?.validate();
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Confirm Password',
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
                            text: 'Confirm Password',
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
                    validator: FormBuilderValidators.compose([
                      if (context.watch<UserProvider>().selectedUser == null)
                        FormBuilderValidators.required(),
                      // reg exp for confirm password should be same as password by using TextEditingController
                      // RegExp(_passwordController.text)
                    ]),
                  ),
                  SizedBox(height: 40),
                  FormBuilderDropdown<String>(
                    initialValue:
                        context.watch<UserProvider>().selectedUser == null
                            ? null
                            : context
                                .watch<UserProvider>()
                                .selectedUser!
                                .appMetadata!['role'],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '-- Select Role --',
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
                            text: 'Role',
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
                    name: 'role',
                    items: List.generate(
                        ['ADMIN', 'COOKER', 'SELLER', 'BOOK'].length, (index) {
                      return DropdownMenuItem(
                        value: ['ADMIN', 'COOKER', 'SELLER', 'BOOK'][index],
                        child: Text(
                          ['ADMIN', 'COOKER', 'SELLER', 'BOOK'][index],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    }),
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
                  if (context.read<UserProvider>().selectedUser == null) {
                    print(_formKey.currentState!.value);
                    String fName = _formKey.currentState!.value['f_name'];
                    String lName = _formKey.currentState!.value['l_name'];
                    String email = _formKey.currentState!.value['email'];
                    String password = _formKey.currentState!.value['password'];
                    String confirmPassword =
                        _formKey.currentState!.value['confirm_password'];

                    // check if password and confirm password are the same
                    if (password != confirmPassword) {
                      _formKey.currentState?.fields['confirm_password']
                          ?.invalidate('Passwords do not match');
                      return;
                    }

                    String role = _formKey.currentState!.value['role'];

                    bool res = await context
                        .read<UserProvider>()
                        .addUser(email, password, fName, lName, role);
                    if (res) {
                      widget.pageController.animateToPage(
                        10,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  } else {
                    print('-' * 100);
                    print(_formKey.currentState!.value);
                    String fName = _formKey.currentState!.value['f_name'];
                    String lName = _formKey.currentState!.value['l_name'];
                    String email = _formKey.currentState!.value['email'];
                    String password = _formKey.currentState!.value['password'];
                    String confirmPassword =
                        _formKey.currentState!.value['confirm_password'];

                    // check if password and confirm password are the same
                    if (password != confirmPassword) {
                      _formKey.currentState?.fields['confirm_password']
                          ?.invalidate('Passwords do not match');
                      return;
                    }

                    print(_formKey.currentState!.value);

                    String role = _formKey.currentState!.value['role'];
                    String uid = context.read<UserProvider>().selectedUser!.id;

                    User? res = await context.read<UserProvider>().updateUser(
                        uid, email, password, fName, lName, role, true);
                    if (res != null) {
                      widget.pageController.animateToPage(
                        10,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  }
                }
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
