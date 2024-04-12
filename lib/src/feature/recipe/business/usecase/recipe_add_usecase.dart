import 'package:admin_dashboard/src/feature/recipe/data/model/recipe_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../repository/recipe_repository.dart';

class RecipeAddUseCase implements UseCase<bool, RecipeModel> {
  final RecipeRepository recipeRepository;

  const RecipeAddUseCase({
    required this.recipeRepository,
  });

  @override
  Future<Either<DatabaseFailure, bool>> call(RecipeModel param) {
    return recipeRepository.addRecipe(param);
  }
}
