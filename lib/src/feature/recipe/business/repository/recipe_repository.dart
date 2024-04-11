import 'package:admin_dashboard/src/feature/recipe/data/model/recipe_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';

abstract class RecipeRepository {
  Future<Either<DatabaseFailure, RecipeModel>> addRecipe(RecipeModel param);

  Future<Either<DatabaseFailure, List<RecipeModel>>> getRecipes(NoParams param);
}
