import 'package:admin_dashboard/src/feature/user/business/param/user_update_param.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../../business/param/user_add_param.dart';
import '../../business/usecase/user_add_usecase.dart';
import '../../business/usecase/user_delete_usecase.dart';
import '../../business/usecase/user_get_user_by_id_usecase.dart';
import '../../business/usecase/user_get_users_usecase.dart';
import '../../business/usecase/user_update_usecase.dart';

class UserProvider with ChangeNotifier {
  final UserAddUseCase userAddUseCase;
  final UserGetUsersUseCase userGetUsersUseCase;
  final UserGetUserByIdUseCase userGetUserByIdUseCase;
  final UserUpdateUseCase userUpdateUserUseCase;
  final UserDeleteUseCase userDeleteUseCase;

  UserProvider({
    required this.userAddUseCase,
    required this.userGetUsersUseCase,
    required this.userGetUserByIdUseCase,
    required this.userUpdateUserUseCase,
    required this.userDeleteUseCase,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  bool _adminIsChecked = true;
  bool get adminIsChecked => _adminIsChecked;
  void setAdminIsChecked(bool value) {
    _adminIsChecked = value;
    notifyListeners();
  }

  bool _cookerIsChecked = true;
  bool get cookerIsChecked => _cookerIsChecked;
  void setCookerIsChecked(bool value) {
    _cookerIsChecked = value;
    notifyListeners();
  }

  bool _sellerIsChecked = true;
  bool get sellerIsChecked => _sellerIsChecked;
  void setSellerIsChecked(bool value) {
    _sellerIsChecked = value;
    notifyListeners();
  }

  bool _bookIsChecked = true;
  bool get bookIsChecked => _bookIsChecked;
  void setBookIsChecked(bool value) {
    _bookIsChecked = value;
    notifyListeners();
  }

  User? _selectedUser;

  User? get selectedUser => _selectedUser;

  void setSelectedUser(User? value) {
    _selectedUser = value;
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

  /* int _selectedIndexCategory = 0;

  int get selectedIndexCategory => _selectedIndexCategory;

  void setSelectedIndexCategory(int value) {
    _selectedIndexCategory = value;
    notifyListeners();
  }*/

  TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  void setTextController(String value) {
    _searchController.text = value;
    notifyListeners();
  }

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  void setExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  /* String _addProductErrorMessage = '';

  String get addProductErrorMessage => _addProductErrorMessage;

  void setAddProductErrorMessage(String value) {
    _addProductErrorMessage = value;
    notifyListeners();
  }*/

  /*Future<String?> uploadImage(Uint8List bytes) async {
    _isLoading = true;
    String? url;
    notifyListeners();
    final result = await productUploadImageUseCase.call(bytes);

    await result.fold((l) async {
      _addProductErrorMessage = l.errorMessage;

      url = null;
    }, (r) async {
      print(r);
      url = r;
    });

    _isLoading = false;
    notifyListeners();
    return url;
  }*/

  /* Future<String?> getSignedUrl(String path) async {
    path = path.split('/').last;
    String? url;

    final result = await productGetSignedUrlUseCase.call(path);

    await result.fold((l) async {
      _addProductErrorMessage = l.errorMessage;

      url = null;
    }, (r) async {
      print(r);
      url = r;
    });

    return url;
  }*/

  Future<List<User>> getUsers() async {
    List<User> users = [];
    final result = await userGetUsersUseCase.call(NoParams());

    await result.fold((l) async {
      print(l.errorMessage);
      users = [];
    }, (r) async {
      print(r);
      users = r;
    });

    return users;
  }

  Future<bool> addUser(String email, String password, String fName, String lName, String role, BuildContext context) async {
    _isLoading = true;
    bool isSuccess = false;
    notifyListeners();
    final result = await userAddUseCase.call(
      UserAddParam(
        email: email,
        password: password,
        fName: fName,
        lName: lName,
        role: role,
        isAvailable: true,
      ),
    );

    await result.fold((l) async {
      print(l.errorMessage);
      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Error!'),
            content: fluent.RichText(
                text: fluent.TextSpan(
              text: 'The user has not been added because of an error. ',
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
            content: const Text('The user has been added successfully. You can add another user or close the form.'),
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

  Future<User?> getUserById(String uid) async {
    User? user;
    final result = await userGetUserByIdUseCase.call(uid);

    await result.fold((l) async {
      print(l.errorMessage);
      user = null;
    }, (r) async {
      print(r.toJson());
      user = r;
    });

    return user;
  }

  Future<bool> updateUser({required String uid, required String email, required String password, required String fName, required String lName, required String role, required bool isAvailable, required BuildContext context}) async {
    print('updateUser from provier');
    print(uid);
    print(email);
    print(password);
    print(fName);
    print(lName);
    print(role);
    print(isAvailable);

    _isLoading = true;
    notifyListeners();
    bool isSuccess = false;
    User? user = await getUserById(uid);
    if (user != null) {
      final result = await userUpdateUserUseCase.call(
        UserUpdateParam(
          uid: uid,
          email: email,
          password: password,
          fName: fName,
          lName: lName,
          role: role,
          isAvailable: isAvailable,
        ),
      );

      await result.fold((l) async {
        print(l.errorMessage);
        await fluent.displayInfoBar(
          context,
          builder: (context, close) {
            return fluent.InfoBar(
              title: const Text('Error!'),
              content: fluent.RichText(
                  text: fluent.TextSpan(
                text: 'The user has not been updated because of an error. ',
                children: [
                  fluent.TextSpan(
                    text: l.errorMessage,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )),
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
        print(r);
        await fluent.displayInfoBar(
          context,
          builder: (context, close) {
            return fluent.InfoBar(
              title: const Text('Success!'),
              content: const Text('The user has been updated successfully. You can add another user or close the form.'),
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
    }

    _isLoading = false;
    notifyListeners();

    return isSuccess;
  }

  Future<bool> deleteUser(String uid) async {
    _isLoading = true;
    bool isSuccess = false;
    notifyListeners();
    final result = await userDeleteUseCase.call(uid);

    await result.fold((l) async {
      print(l.errorMessage);
      isSuccess = false;
    }, (r) async {
      print(r);
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
