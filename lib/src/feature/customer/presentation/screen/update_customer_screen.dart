import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../category/data/model/category_model.dart';
import '../../data/model/customer_model.dart';
import '../provider/customer_provider.dart';

class UpdateCustomerScreen extends StatelessWidget {
  final int customerId;
  UpdateCustomerScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      padding: EdgeInsets.zero,
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
      ),
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height - 60,
          ),
          color: FluentTheme.of(context)
              .navigationPaneTheme
              .overlayBackgroundColor,
          child: Card(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: FutureBuilder(
              future:
                  context.read<CustomerProvider>().getCustomerById(customerId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('data');
                  print(snapshot.data);
                  CustomerModel customerModel = snapshot.data as CustomerModel;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: UpdateCustomerForm(
                      customerModel: customerModel,
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
      ],
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

  // controller for name
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    nameController.text = widget.customerModel.fName;
    descriptionController.text = widget.customerModel.lName;
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
                controller: nameController,
                placeholder: 'Name',
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
              child: context.watch<CustomerProvider>().isLoading
                  ? const ProgressRing()
                  : Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 30,
                      child: const Text('Update Category')),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print('add category');
                  String name = nameController.text;
                  String description = descriptionController.text;

                   /* CustomerModel oldCustomer = widget.customerModel;
                  CustomerModel newCategory = CustomerModel(
                      id: oldCustomer.id,
                      name: oldCategory.name != name ? name : oldCategory.name,
                      description: oldCategory.description != description
                          ? description
                          : oldCategory.description,
                      imageUrl: oldCategory.imageUrl,
                      createdAt: oldCategory.createdAt,
                      updatedAt: DateTime.now(),
                      isVisible: oldCategory.isVisible,
                    );
                    bool res = await context
                        .read<CustomerProvider>()
                        .updateCustomer(newCategory, context);*/

                } else {
                  print('form is not valid');
                }
              }),
        ],
      ),
    );
  }
}
