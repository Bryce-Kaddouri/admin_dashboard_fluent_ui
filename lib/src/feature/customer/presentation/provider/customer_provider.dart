import 'package:admin_dashboard/src/feature/customer/business/param/customer_add_param.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_add_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_delete_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_get_customer_by_id_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_get_customers_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_update_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/data/model/customer_model.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';

import '../../../../core/data/usecase/usecase.dart';

class CustomerProvider with ChangeNotifier {
  final CustomerAddUseCase customerAddUseCase;
  final CustomerUpdateUseCase customerUpdateUseCase;
  final CustomerDeleteUseCase customerDeleteUseCase;
  final CustomerGetCustomerByIdUseCase customerGetCustomerByIdUseCase;
  final CustomerGetCustomersUseCase customerGetCustomersUseCase;

  CustomerProvider({
    required this.customerAddUseCase,
    required this.customerUpdateUseCase,
    required this.customerDeleteUseCase,
    required this.customerGetCustomerByIdUseCase,
    required this.customerGetCustomersUseCase,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int _nbItemPerPage = 10;

  int get nbItemPerPage => _nbItemPerPage;

  void setNbItemPerPage(int value) {
    _nbItemPerPage = value;
    notifyListeners();
  }

  String _searchText = '';

  String get searchText => _searchText;

  void setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  void setTextController(String value) {
    _searchController.text = value;
    notifyListeners();
  }

  Future<List<CustomerModel>> getCustomers() async {
    List<CustomerModel> customerList = [];
    final result = await customerGetCustomersUseCase.call(NoParams());

    await result.fold((l) async {
      print(l.errorMessage);
    }, (r) async {
      print(r);
      customerList = r;
    });

    return customerList;
  }

  Future<bool> addCustomer(String fName, String lName, String phoneNumber,
      String countryCode, bool isEnable, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;
    final result = await customerAddUseCase.call(CustomerAddParam(
        fName: fName,
        lName: lName,
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        isEnable: true));

    await result.fold((l) async {
      print(l.errorMessage);

      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Error!'),
            content: fluent.RichText(
                text: fluent.TextSpan(
              text: 'The customer has not been added because of an error. ',
              children: [
                fluent.TextSpan(
                  text: l.errorMessage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )),

            /*'The user has not been added because of an error. ${l.errorMessage}'*/

            action: IconButton(
              icon: const Icon(fluent.FluentIcons.clear),
              onPressed: close,
            ),
            severity: fluent.InfoBarSeverity.error,
          );
        },
        alignment: Alignment.topRight,
        duration: const Duration(seconds: 5),
      );

      isSuccess = false;
    }, (r) async {
      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Success!'),
            content: const Text(
                'The customer has been added successfully. You can add another customer or close the form.'),
            action: IconButton(
              icon: const Icon(fluent.FluentIcons.clear),
              onPressed: close,
            ),
            severity: fluent.InfoBarSeverity.success,
          );
        },
        alignment: Alignment.topRight,
        duration: const Duration(seconds: 5),
      );
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  Future<CustomerModel?> getCustomerById(int id) async {
    CustomerModel? customerModel;
    final result = await customerGetCustomerByIdUseCase.call(id);

    await result.fold((l) async {
      print(l.errorMessage);
      print('error from getCustomerById');
      print(l);
    }, (r) async {
      print(r.toJson());
      customerModel = r;

      print('customerModel: $customerModel');
    });

    return customerModel;
  }

  Future<bool> updateCustomer(
      CustomerModel customer, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    bool isSuccess = false;

    final result = await customerUpdateUseCase.call(customer);

    await result.fold((l) async {
      print(l.errorMessage);
      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Error!'),
            content: fluent.RichText(
                text: fluent.TextSpan(
              text: 'The customer has not been updated because of an error. ',
              children: [
                fluent.TextSpan(
                  text: l.errorMessage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )),

            /*'The user has not been added because of an error. ${l.errorMessage}'*/

            action: IconButton(
              icon: const Icon(fluent.FluentIcons.clear),
              onPressed: close,
            ),
            severity: fluent.InfoBarSeverity.error,
          );
        },
        alignment: Alignment.topRight,
        duration: const Duration(seconds: 5),
      );
      isSuccess = false;
    }, (r) async {
      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Success!'),
            content: const Text(
                'The customer has been updated successfully. You can update another customer or close the form.'),
            action: IconButton(
              icon: const Icon(fluent.FluentIcons.clear),
              onPressed: close,
            ),
            severity: fluent.InfoBarSeverity.success,
          );
        },
        alignment: Alignment.topRight,
        duration: const Duration(seconds: 5),
      );
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();

    return isSuccess;
  }

  Future<bool> deleteCustomer(int id) async {
    _isLoading = true;
    bool isSuccess = false;
    notifyListeners();
    final result = await customerDeleteUseCase.call(id);

    await result.fold((l) async {
      print(l.errorMessage);

      isSuccess = false;
    }, (r) async {
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
