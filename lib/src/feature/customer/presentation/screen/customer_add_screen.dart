import 'package:admin_dashboard/src/feature/customer/presentation/screen/update_customer_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import material dart
import 'package:flutter/material.dart' as material;
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

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
  PhoneController phoneNumberController = PhoneController();
  FocusNode focusNode = FocusNode();

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
                  child: material.Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: PhoneFieldView(
                      controller: phoneNumberController,
                      focusNode: focusNode,
                      isCountryButtonPersistent: true,
                      mobileOnly: true,
                      locale: Locale('IE'),
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
                        String phoneNumber = phoneNumberController.value.nsn;
                        String countryCode =
                            phoneNumberController.value.countryCode;
                        IsoCode isoCode = phoneNumberController.value.isoCode;
                        print('fName: $fName');
                        print('lName: $lName');
                        print('phoneNumber: $phoneNumber');
                        print('countryCode: $countryCode');

                        bool res = await context
                            .read<CustomerProvider>()
                            .addCustomer(fName, lName, phoneNumber, countryCode,
                                true, context, isoCode);
                        if (res) {
                          fNameController.clear();
                          lNameController.clear();
                          phoneNumberController.value =
                              const PhoneNumber(isoCode: IsoCode.IE, nsn: '');
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
