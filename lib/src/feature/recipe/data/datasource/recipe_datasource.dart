import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:admin_dashboard/src/feature/recipe/data/model/recipe_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';

class RecipeDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, bool>> addRecipe(RecipeModel params) async {
    try {
      Map<String, dynamic> recipeResponse = await _client.from('recipes').insert(params.toJson(isToAdd: true)).select().single();
      print('response recipes');
      print(recipeResponse);
      int recipeId = recipeResponse['id'];
      Map<String, dynamic> finalRecipe = {};
      finalRecipe['id'] = recipeId;
      finalRecipe['name'] = recipeResponse['name'];
      finalRecipe['created_at'] = DateTime.parse(recipeResponse['created_at']);
      finalRecipe['photo_url'] = recipeResponse['photo_url'];
      finalRecipe['description'] = recipeResponse['description'];
      finalRecipe['ingredients'] = [];
      finalRecipe['steps'] = [];
      finalRecipe['product_ids'] = [];

      for (var ing in params.ingredients) {
        double qty = ing.quantity;
        IngredientType ingredientType = ing.type!;
        String unit = ing.unit!;
        qty = RecipeIngredientModel.convertToGram(qty, ingredientType, unit);

        Map<String, dynamic> response = await _client
            .from('recipe_ingredients')
            .insert({
              'recipe_id': recipeId,
              'ingredient_id': ing.ingredientId,
              'quantity': qty,
            })
            .select()
            .single();
        print('response recipe_ingredients');
        print(response);
        finalRecipe['ingredients'].add(response);
      }

      for (var step in params.steps) {
        Map<String, dynamic> response = await _client
            .from('recipe_steps')
            .insert({
              'recipe_id': recipeId,
              'description': step.description,
              'step_number': step.stepNumber,
            })
            .select()
            .single();
        print('response recipe_steps');
        print(response);
        finalRecipe['steps'].add(response);
      }

      /*for (int productId in params.productIds) {
        Map<String, dynamic> response = await _client
            .from('recipe_products')
            .insert({
              'recipe_id': recipeId,
              'product_id': productId,
            })
            .select()
            .single();
        print('response recipe_products');
        print(response);
        finalRecipe['product_ids'].add(response);
      }*/

      print('final recipe');
      print(finalRecipe);

      return const Right(true);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print('error');
      print(e);
      return Left(DatabaseFailure(errorMessage: e.toString()));
    }
  }

  Future<Either<DatabaseFailure, List<RecipeModel>>> getRecipes() async {
    try {
      List<Map<String, dynamic>> response = await _client.from('all_recipes_view').select().order('name', ascending: true);

      print('response getRecipes');
      print(response);

      List<RecipeModel> recipeList = [];
      for (Map<String, dynamic> json in response) {
        print('json');
        RecipeModel ingredient = RecipeModel.fromJson(json);
        recipeList.add(ingredient);
      }
      print('recipeListList');
      print(recipeList.length);
      return Right(recipeList);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting recipeListList'));
    }
  }

  Future<Either<DatabaseFailure, RecipeModel>> getRecipeById(int id) async {
    try {
      Map<String, dynamic> response = await _client.from('all_recipes_view').select().eq('id', id).single();

      print('response getRecipeBy Id');
      print(response);

      RecipeModel recipe = RecipeModel.fromJson(response);
      print('recipe model');
      print(recipe);
      return Right(recipe);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting recipeListList'));
    }
  }
}
