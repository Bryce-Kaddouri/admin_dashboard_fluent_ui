import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../../../core/data/exception/failure.dart';
import '../param/login_params.dart';
import '../repository/auth_repository.dart';

class AuthLogoutUseCase implements UseCase<String, NoParams> {
  final AuthRepository authRepository;

  const AuthLogoutUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<AuthFailure, String>> call(NoParams param) {
    return authRepository.logout(param);
  }
}
