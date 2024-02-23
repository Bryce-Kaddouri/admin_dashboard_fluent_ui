import 'package:admin_dashboard/src/core/data/exception/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class AuthOnAuthOnAuthChangeUseCase
    implements SingleUseCase<Stream<AuthState>, NoParams> {
  final AuthRepository authRepository;

  const AuthOnAuthOnAuthChangeUseCase({
    required this.authRepository,
  });

  @override
  Stream<AuthState> call(NoParams params) {
    return authRepository.onAuthStateChange(params);
  }
}
