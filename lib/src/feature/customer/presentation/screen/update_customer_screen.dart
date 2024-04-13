import 'package:fluent_ui/fluent_ui.dart';
// import material dart
import 'package:flutter/material.dart' as material;
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

import '../../data/model/customer_model.dart';
import '../provider/customer_provider.dart';

class UpdateCustomerScreen extends StatelessWidget {
  final int customerId;
  UpdateCustomerScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(
        elevation: 4,
        shadowColor: FluentTheme.of(context).shadowColor,
        surfaceTintColor:
            FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        backgroundColor:
            FluentTheme.of(context).navigationPaneTheme.backgroundColor,
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
          color: FluentTheme.of(context)
              .navigationPaneTheme
              .overlayBackgroundColor,
          child: FutureBuilder<CustomerModel?>(
            future:
                context.read<CustomerProvider>().getCustomerById(customerId),
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
  PhoneController phoneController = PhoneController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    fNameController.text = widget.customerModel.fName;
    lNameController.text = widget.customerModel.lName;
    phoneController.value = PhoneNumber(
        isoCode: widget.customerModel.isoCode!,
        nsn: widget.customerModel.phoneNumber);
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
              child: Container(
                width: double.infinity,
                child: PhoneFieldView(
                  controller: phoneController,
                  focusNode: focusNode,
                  isCountryButtonPersistent: true,
                  mobileOnly: true,
                  locale: Locale('ie'),
                ),
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
                      child: const Text('Update Category')),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print('add customer');
                  String fName = fNameController.text;
                  String lName = lNameController.text;
                  String phoneNumber = phoneController.value.nsn;
                  String countryCode = phoneController.value.countryCode;

                  CustomerModel oldCustomer = widget.customerModel;
                  CustomerModel newCustomer = CustomerModel(
                      isoCode: phoneController.value.isoCode,
                      id: oldCustomer.id,
                      fName: oldCustomer.fName != fName
                          ? fName
                          : oldCustomer.fName,
                      lName: oldCustomer.lName != lName
                          ? lName
                          : oldCustomer.lName,
                      createdAt: oldCustomer.createdAt,
                      updatedAt: DateTime.now(),
                      phoneNumber: oldCustomer.phoneNumber != phoneNumber
                          ? phoneNumber
                          : oldCustomer.phoneNumber,
                      countryCode: oldCustomer.countryCode != countryCode
                          ? countryCode
                          : oldCustomer.countryCode,
                      isEnable: oldCustomer.isEnable);

                  bool res = await context
                      .read<CustomerProvider>()
                      .updateCustomer(newCustomer, context);
                } else {
                  print('form is not valid');
                }
              }),
        ],
      ),
    );
  }
}

class PhoneFieldView extends StatefulWidget {
  final PhoneController controller;
  final FocusNode focusNode;

  final bool isCountryButtonPersistent;
  final bool mobileOnly;
  final Locale locale;
  final bool isReadOnly;

  const PhoneFieldView({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.isCountryButtonPersistent,
    required this.mobileOnly,
    required this.locale,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<PhoneFieldView> createState() => _PhoneFieldViewState();

  static bool validPhoneNumber(PhoneController phoneNumber) {
    bool isValid = true;
    if (phoneNumber.value.isValidLength() == false) {
      isValid = false;
    } else if (phoneNumber.value.isValid() == false) {
      isValid = false;
    }

    return isValid;
  }
}

class _PhoneFieldViewState extends State<PhoneFieldView> {
  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        padding: EdgeInsets.all(0),
        child: AutofillGroup(
          child: PhoneFormField(
            countryButtonStyle: CountryButtonStyle(
              showDialCode: true,
              showDropdownIcon: true,
              showIsoCode: false,
              showFlag: true,
            ),
            enabled: !widget.isReadOnly,
            focusNode: widget.focusNode,
            controller: widget.controller,
            isCountryButtonPersistent: widget.isCountryButtonPersistent,
            autofocus: false,
            textAlignVertical: TextAlignVertical.center,
            autofillHints: const [AutofillHints.telephoneNumber],
            countrySelectorNavigator: CountrySelectorNavigator.page(
              searchBoxIconColor: FluentTheme.of(context).accentColor,
              noResultMessage: 'No result found',
              searchBoxDecoration: material.InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.transparent,
                border: material.InputBorder.none,
              ),
            ),
            decoration: material.InputDecoration(
              border: material.InputBorder.none,
              hintText: 'Phone Number',
              filled: true,
              fillColor: Colors.transparent,
            ),
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: (p) {
              if (p.nsn.length > 9) {
                PhoneNumber phone =
                    PhoneNumber(isoCode: p.isoCode, nsn: p.nsn.substring(0, 9));
                widget.controller.value = phone;
              }
            },
          ),
        ));
  }
}
