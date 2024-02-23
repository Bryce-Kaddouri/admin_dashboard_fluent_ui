import 'package:admin_dashboard/src/feature/user/business/param/user_update_param.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

  List<String> _roles = ['ADMIN', 'COOKER', 'SELLER', 'BOOK'];

  List<String> get roles => _roles;

  void setRoles(List<String> value) {
    _roles = value;
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

  Future<bool> addUser(String email, String password, String fName,
      String lName, String role) async {
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
      Get.snackbar(
        'Error',
        l.errorMessage,
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
      isSuccess = false;
    }, (r) async {
      print(r.toJson());
      Get.snackbar(
        'Success',
        'User added successfully',
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

  Future<User?> updateUser(String uid, String email, String password,
      String fName, String lName, String role, bool isAvailable) async {
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
        user = null;
      }, (r) async {
        print(r.toJson());
        user = r;
      });
    }

    _isLoading = false;
    notifyListeners();

    return user;
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
