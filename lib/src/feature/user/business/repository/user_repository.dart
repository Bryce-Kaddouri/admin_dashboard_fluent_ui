import 'dart:typed_data';

import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';
import 'package:admin_dashboard/src/feature/user/business/param/user_update_param.dart';
/*
import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
*/
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../param/user_add_param.dart';
/*
import '../../data/model/category_model.dart';
*/

abstract class UserRepository {
  Future<Either<DatabaseFailure, User>> addUser(UserAddParam params);

  Future<Either<DatabaseFailure, List<User>>> getUsers(NoParams param);

  Future<Either<DatabaseFailure, User>> getUserById(String uid);

  Future<Either<DatabaseFailure, User>> updateUser(UserUpdateParam user);

  Future<Either<DatabaseFailure, bool>> deleteUser(String uid);
}
