import 'package:admin_dashboard/src/core/data/exception/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class AuthGetUserUseCase implements SingleUseCase<User?, NoParams> {
  final AuthRepository authRepository;

  const AuthGetUserUseCase({
    required this.authRepository,
  });

  @override
  User? call(NoParams params) {
    return authRepository.getUser(params);
  }
}
