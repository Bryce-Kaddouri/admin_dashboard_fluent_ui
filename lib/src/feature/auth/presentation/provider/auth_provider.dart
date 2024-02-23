import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_login_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_on_auth_change_usecase.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../../business/param/login_params.dart';
import '../../business/usecase/auth_get_user_usecase.dart';
import '../../business/usecase/auth_is_looged_in_usecase.dart';
import '../../business/usecase/auth_logout_usecase.dart';

class AuthProvider with ChangeNotifier {
  final AuthLoginUseCase authLoginUseCase;
  final AuthLogoutUseCase authLogoutUseCase;
  final AuthGetUserUseCase authGetUserUseCase;
  final AuthIsLoggedInUseCase authIsLoggedInUseCase;
  final AuthOnAuthOnAuthChangeUseCase authOnAuthChangeUseCase;

  AuthProvider({
    required this.authLoginUseCase,
    required this.authLogoutUseCase,
    required this.authGetUserUseCase,
    required this.authIsLoggedInUseCase,
    required this.authOnAuthChangeUseCase,
  });

  bool checkIsLoggedIn() {
    return authIsLoggedInUseCase.call(NoParams());
  }

  User? getUser() {
    return authGetUserUseCase.call(NoParams());
  }

  Future<void> logout() async {
    await authLogoutUseCase.call(NoParams());
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _loginErrorMessage = '';

  String get loginErrorMessage => _loginErrorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    bool isSuccess = false;
    notifyListeners();
    final result = await authLoginUseCase
        .call(LoginParams(email: email, password: password));

    await result.fold((l) async {
      _loginErrorMessage = l.errorMessage;
      isSuccess = false;
    }, (r) async {
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  Stream<AuthState> onAuthStateChange() {
    return authOnAuthChangeUseCase.call(NoParams());
  }
}
