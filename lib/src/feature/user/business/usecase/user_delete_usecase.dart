/*
import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/business/repository/category_repository.dart';
import 'package:admin_dashboard/src/feature/product/business/repository/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/user_model.dart';
*/
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/user_repository.dart';

class UserDeleteUseCase implements UseCase<bool, String> {
  final UserRepository userRepository;

  const UserDeleteUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<DatabaseFailure, bool>> call(String uid) {
    return userRepository.deleteUser(uid);
  }
}
