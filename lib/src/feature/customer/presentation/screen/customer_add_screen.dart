import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import material dart
import 'package:flutter/material.dart' as material;

import '../provider/customer_provider.dart';

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
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                InfoLabel(
                  label: 'Enter customer first name:',
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 500, maxHeight: 50),
                    child: TextFormBox(
                      controller: fNameController,
                      placeholder: 'First Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter customer first name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 50),
                InfoLabel(
                  label: 'Enter customer last name:',
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 500, maxHeight: 50),
                    child: TextFormBox(
                      controller: lNameController,
                      placeholder: 'Last Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter customer last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 50),

            Container(
              alignment: Alignment.center,
              height: 100,
              constraints: BoxConstraints(maxWidth: 500, maxHeight: 100),
              child:
                material.Card(
                  elevation: 0,
                  child:
                IntlPhoneField(
                  validator: (value) {
                    if (value == null ) {
                      return 'Please enter phone number';
                    }else if (value.isValidNumber() == false) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  flagsButtonPadding: EdgeInsets.all(10),
                  decoration: material.InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    constraints: BoxConstraints(maxWidth: 500, maxHeight: 100, minHeight: 100),

                    labelText: 'Phone Number',
                    border: material.OutlineInputBorder(
                    ),
                    enabledBorder: material.OutlineInputBorder(
                    ),
                    focusedBorder: material.OutlineInputBorder(
                    ),
                  ),
                  initialCountryCode: 'IE',
                  controller: phoneNumberController,
                  onChanged: (phone) {
                    print(phone.completeNumber);
                    setState(() {
                      countryCodeController.text = phone.countryCode;
                    });
                  },
                ),
                ),
            ),

                const SizedBox(height: 100),
                FilledButton(
                    child: context.watch<CustomerProvider>().isLoading
                        ? const ProgressRing()
                        : Container(
                            alignment: Alignment.center,
                            width: 200,
                            height: 30,
                            child: const Text('Add Customer')),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print('add category');
                        String fName = fNameController.text;
                        String lName = lNameController.text;
                        String phoneNumber = phoneNumberController.text;
                        String countryCode = countryCodeController.text;
                        print('fName: $fName');
                        print('lName: $lName');
                        print('phoneNumber: $phoneNumber');
                        print('countryCode: $countryCode');

                          bool res = await context
                              .read<CustomerProvider>()
                              .addCustomer(fName, lName, phoneNumber, countryCode, true, context);
                          if (res) {
                            fNameController.clear();
                            lNameController.clear();
                            phoneNumberController.clear();
                            countryCodeController.clear();

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
