/*
import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/business/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/user_model.dart';
import '../repository/user_repository.dart';
*/

import 'package:admin_dashboard/src/feature/user/business/param/user_add_param.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../param/user_update_param.dart';
import '../repository/user_repository.dart';

class UserUpdateUseCase implements UseCase<User, UserUpdateParam> {
  final UserRepository userRepository;

  const UserUpdateUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<DatabaseFailure, User>> call(UserUpdateParam param) {
    return userRepository.updateUser(param);
  }
}
