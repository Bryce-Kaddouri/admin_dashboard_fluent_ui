import 'package:admin_dashboard/src/core/data/exception/failure.dart';
import 'package:admin_dashboard/src/core/data/usecase/usecase.dart';
import 'package:admin_dashboard/src/feature/recipe/data/datasource/recipe_datasource.dart';
import 'package:admin_dashboard/src/feature/recipe/data/model/recipe_model.dart';
import 'package:dartz/dartz.dart';

import '../../business/repository/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  final RecipeDataSource dataSource;

  RecipeRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DatabaseFailure, bool>> addRecipe(RecipeModel param) async {
    return await dataSource.addRecipe(param);
  }

  @override
  Future<Either<DatabaseFailure, List<RecipeModel>>> getRecipes(NoParams param) async {
    return await dataSource.getRecipes();
  }

  @override
  Future<Either<DatabaseFailure, RecipeModel>> getRecipeById(int recipeId) async {
    return await dataSource.getRecipeById(recipeId);
  }
}
