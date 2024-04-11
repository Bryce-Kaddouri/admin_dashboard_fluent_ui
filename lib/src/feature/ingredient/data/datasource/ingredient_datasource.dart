import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';

class IngredientDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, IngredientModel>> addIngredient(IngredientModel params) async {
    try {
      Map<String, dynamic> response = await _client.from('ingredients').insert(params.toJson(isToAdd: true)).select().single();
      print('response addIngredient');
      print(response);
      IngredientModel ingredientModel = IngredientModel.fromJson(response);
      print(ingredientModel.toJson());
      return Right(ingredientModel);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: e.toString()));
    }
  }

  Future<Either<DatabaseFailure, List<IngredientModel>>> getIngredients() async {
    try {
      List<Map<String, dynamic>> response = await _client.from('ingredients').select().order('id', ascending: true);

      print('response getIngredients');
      print(response);

      List<IngredientModel> ingredientList = [];
      for (Map<String, dynamic> json in response) {
        print('json');
        IngredientModel ingredient = IngredientModel.fromJson(json);
        ingredientList.add(ingredient);
      }
      print('ingredientList');
      print(ingredientList.length);
      return Right(ingredientList);
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: error.message));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error getting products'));
    }
  }
}
