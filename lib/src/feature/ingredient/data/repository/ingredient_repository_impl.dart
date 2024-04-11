import 'package:admin_dashboard/src/core/data/exception/failure.dart';
import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:admin_dashboard/src/feature/ingredient/business/repository/ingredient_repository.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/datasource/ingredient_datasource.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:dartz/dartz.dart';

class IngredientRepositoryImpl extends IngredientRepository {
  final IngredientDataSource dataSource;

  IngredientRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DatabaseFailure, IngredientModel>> addIngredient(IngredientModel param) async {
    return await dataSource.addIngredient(param);
  }

  @override
  Future<Either<DatabaseFailure, List<IngredientModel>>> getIngredients(NoParams param) async {
    return await dataSource.getIngredients();
  }
}
