import 'package:fluent_ui/fluent_ui.dart';
// import material dart
import 'package:flutter/material.dart' as material;
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../data/model/customer_model.dart';
import '../provider/customer_provider.dart';

class UpdateCustomerScreen extends StatelessWidget {
  final int customerId;
  UpdateCustomerScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
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
                context.go('/customer');
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text('Update Customer', style: TextStyle(fontSize: 20)),
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
        title: Text('Update Customer'),
        leading: material.BackButton(
          onPressed: () {
            context.go('/customer');
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
          child: FutureBuilder<CustomerModel?>(
            future: context.read<CustomerProvider>().getCustomerById(customerId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('data');
                print(snapshot.data);
                CustomerModel customerModel = snapshot.data!;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: UpdateCustomerForm(
                    customerModel: customerModel,
                  ),
                );
              } else if (snapshot.hasError) {
                print('error');
                print(snapshot.error);
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

class UpdateCustomerForm extends StatefulWidget {
  CustomerModel customerModel;
  UpdateCustomerForm({super.key, required this.customerModel});

  @override
  State<UpdateCustomerForm> createState() => _UpdateCustomerFormState();
}

class _UpdateCustomerFormState extends State<UpdateCustomerForm> {
  final _formKey = GlobalKey<FormState>();

  // controller for first name
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fNameController.text = widget.customerModel.fName;
    lNameController.text = widget.customerModel.lName;
    phoneNumberController.text = widget.customerModel.phoneNumber;
    countryCodeController.text = widget.customerModel.countryCode;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
              child: IntlPhoneField(
                validator: (value) {
                  if (value == null) {
                    return 'Please enter phone number';
                  } else if (value.isValidNumber() == false) {
                    return 'Please enter valid phone number';
                  }
                  return null;
                },
                flagsButtonPadding: EdgeInsets.all(10),
                decoration: material.InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  constraints: BoxConstraints(maxWidth: 500, maxHeight: 100, minHeight: 100),
                  labelText: 'Phone Number',
                  border: material.OutlineInputBorder(),
                  enabledBorder: material.OutlineInputBorder(),
                  focusedBorder: material.OutlineInputBorder(),
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
              child: context.watch<CustomerProvider>().isLoading ? const ProgressRing() : Container(alignment: Alignment.center, width: 200, height: 30, child: const Text('Update Category')),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print('add customer');
                  String fName = fNameController.text;
                  String lName = lNameController.text;
                  String phoneNumber = phoneNumberController.text;
                  String countryCode = countryCodeController.text;

                  CustomerModel oldCustomer = widget.customerModel;
                  CustomerModel newCustomer = CustomerModel(id: oldCustomer.id, fName: oldCustomer.fName != fName ? fName : oldCustomer.fName, lName: oldCustomer.lName != lName ? lName : oldCustomer.lName, createdAt: oldCustomer.createdAt, updatedAt: DateTime.now(), phoneNumber: oldCustomer.phoneNumber != phoneNumber ? phoneNumber : oldCustomer.phoneNumber, countryCode: oldCustomer.countryCode != countryCode ? countryCode : oldCustomer.countryCode, isEnable: oldCustomer.isEnable);

                  bool res = await context.read<CustomerProvider>().updateCustomer(newCustomer, context);
                } else {
                  print('form is not valid');
                }
              }),
        ],
      ),
    );
  }
}
