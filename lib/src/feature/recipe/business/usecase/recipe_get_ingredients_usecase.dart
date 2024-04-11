import 'package:admin_dashboard/src/feature/recipe/business/repository/recipe_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/recipe_model.dart';

class RecipeGetRecipesUseCase implements UseCase<List<RecipeModel>, NoParams> {
  final RecipeRepository recipeRepository;

  const RecipeGetRecipesUseCase({
    required this.recipeRepository,
  });

  @override
  Future<Either<DatabaseFailure, List<RecipeModel>>> call(NoParams params) {
    return recipeRepository.getRecipes(params);
  }
}
