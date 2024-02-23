import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/user_repository.dart';

class UserGetUsersUseCase implements UseCase<List<User>, NoParams> {
  final UserRepository userRepository;

  const UserGetUsersUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<DatabaseFailure, List<User>>> call(NoParams params) {
    return userRepository.getUsers(params);
  }
}
