import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../param/user_add_param.dart';
import '../repository/user_repository.dart';

class UserAddUseCase implements UseCase<User, UserAddParam> {
  final UserRepository userRepository;

  const UserAddUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<DatabaseFailure, User>> call(UserAddParam params) {
    return userRepository.addUser(params);
  }
}
