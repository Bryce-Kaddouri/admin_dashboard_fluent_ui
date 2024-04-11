import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';

abstract class IngredientRepository {
  Future<Either<DatabaseFailure, IngredientModel>> addIngredient(IngredientModel param);

  Future<Either<DatabaseFailure, List<IngredientModel>>> getIngredients(NoParams param);
}
