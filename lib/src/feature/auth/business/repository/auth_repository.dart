import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/data/exception/failure.dart';
import '../param/login_params.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, AuthResponse>> login(LoginParams params);

  Future<Either<AuthFailure, String>> logout(NoParams param);

  bool isLoggedIn(NoParams param);

  User? getUser(NoParams param);

  Stream<AuthState> onAuthStateChange(NoParams param);

/*bool isLoggedIn();
  String getUserToken();*/
}
