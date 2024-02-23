import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/user_repository.dart';

class UserGetUserByIdUseCase implements UseCase<User, String> {
  final UserRepository userRepository;

  const UserGetUserByIdUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<DatabaseFailure, User>> call(String uid) {
    return userRepository.getUserById(uid);
  }
}
