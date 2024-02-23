/*
import 'dart:typed_data';

import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';
import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../business/param/user_add_param.dart';
*/

import 'package:admin_dashboard/src/feature/user/business/param/user_add_param.dart';
import 'package:admin_dashboard/src/feature/user/business/param/user_update_param.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../product/data/model/product_model.dart';

class UserDataSource {
  SupabaseClient _supaAdminClient = SupabaseClient(
      'https://qlhzemdpzbonyqdecfxn.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsaHplbWRwemJvbnlxZGVjZnhuIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwNDg4NjgwNiwiZXhwIjoyMDIwNDYyODA2fQ.iGkTZL6qeM5f6kXobuo2b6CUdHigONycJuofyjWtEpU');

  Future<Either<DatabaseFailure, User>> addUser(UserAddParam params) async {
    try {
      UserResponse res =
          await _supaAdminClient.auth.admin.createUser(AdminUserAttributes(
        email: params.email,
        password: params.password,
        userMetadata: {
          'fName': params.fName,
          'lName': params.lName,
          'isAvailable': params.isAvailable
        },
        appMetadata: {'role': params.role},
        emailConfirm: true,
      ));
      print(res);
      if (res.user != null) {
        return Right(res.user!);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error adding user'));
      }
    } on AuthException catch (error) {
      print('auth error');
      print(error.message);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error adding user'));
    }
  }

  Future<Either<DatabaseFailure, List<User>>> getUsers() async {
    try {
      List<User> response = await _supaAdminClient.auth.admin.listUsers();
      if (response.isNotEmpty) {
        return Right(response);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting users'));
      }
    } on AuthException catch (error) {
      print('auth error');
      print(error.message);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting users'));
    }
  }

  Future<Either<DatabaseFailure, User>> getUserById(String uid) async {
    try {
      UserResponse response =
          await _supaAdminClient.auth.admin.getUserById(uid);
      if (response.user != null) {
        return Right(response.user!);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting user'));
      }
    } on AuthException catch (error) {
      print('auth error');
      print(error.message);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting user'));
    }
  }

  Future<Either<DatabaseFailure, User>> updateUser(
      UserUpdateParam param) async {
    try {
      print('updateUser --');
      print(param.toJson());
      UserResponse response = await _supaAdminClient.auth.admin.updateUserById(
        param.uid,
        attributes: AdminUserAttributes(
          email: param.email,
          password: param.password.isEmpty ? null : param.password,

/*
          password: param.password,
*/
          userMetadata: {
            'fName': param.fName,
            'lName': param.lName,
            'isAvailable': param.isAvailable
          },
          appMetadata: {'role': param.role},
        ),
      );
      if (response.user != null) {
        return Right(response.user!);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error updating user'));
      }
    } on AuthException catch (error) {
      print('auth error');
      print(error.message);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error updating user'));
    }
  }

  // method to delete category
  Future<Either<DatabaseFailure, bool>> deleteUser(String uid) async {
    try {
      _supaAdminClient.auth.admin.deleteUser(uid);
      return Right(true);
    } on AuthException catch (error) {
      print('auth error');
      print(error.message);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error deleting user'));
    }
  }
}
