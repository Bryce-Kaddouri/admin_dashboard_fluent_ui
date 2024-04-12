import 'package:admin_dashboard/src/feature/recipe/business/repository/recipe_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../data/model/recipe_model.dart';

class RecipeGetRecipeByIdUseCase implements UseCase<RecipeModel, int> {
  final RecipeRepository recipeRepository;

  const RecipeGetRecipeByIdUseCase({
    required this.recipeRepository,
  });

  @override
  Future<Either<DatabaseFailure, RecipeModel>> call(int recipeId) {
    return recipeRepository.getRecipeById(recipeId);
  }
}
