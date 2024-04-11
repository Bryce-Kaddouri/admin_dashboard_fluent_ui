import 'package:admin_dashboard/src/feature/recipe/business/usecase/recipe_add_usecase.dart';
import 'package:admin_dashboard/src/feature/recipe/business/usecase/recipe_get_ingredients_usecase.dart';
import 'package:admin_dashboard/src/feature/recipe/data/model/recipe_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/data/usecase/usecase.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeGetRecipesUseCase recipeGetRecipesUseCase;
  final RecipeAddUseCase recipeAddUseCase;

  RecipeProvider({
    required this.recipeGetRecipesUseCase,
    required this.recipeAddUseCase,
  });

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _searchText = '';
  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  int _nbItemPerPage = 10;
  int get nbItemPerPage => _nbItemPerPage;

  void setNbItemPerPage(int nbItemPerPage) {
    _nbItemPerPage = nbItemPerPage;
    notifyListeners();
  }

  List<RecipeModel> _recipes = [];
  List<RecipeModel> get recipes => _recipes;

  Future<void> getRecipes() async {
    final result = await recipeGetRecipesUseCase.call(NoParams());
    result.fold(
      (failure) => print('Error: $failure'),
      (ingredients) {
        _recipes = ingredients;
        notifyListeners();
      },
    );
  }

  List<RecipeIngredientModel> _draftList = [];
  List<RecipeIngredientModel> get draftList => _draftList;

  void addDraft(RecipeIngredientModel ingredient) {
    _draftList.add(ingredient);
    notifyListeners();
  }

  void removeDraft(RecipeIngredientModel ingredient) {
    _draftList.remove(ingredient);
    notifyListeners();
  }

  void clearDraft() {
    _draftList.clear();
    notifyListeners();
  }

  List<RecipeStepModel> _draftSteps = [];
  List<RecipeStepModel> get draftSteps => _draftSteps;

  void addDraftStep(RecipeStepModel step) {
    _draftSteps.add(step);
    notifyListeners();
  }

  void removeDraftStep(RecipeStepModel step) {
    _draftSteps.remove(step);
    notifyListeners();
  }

  void clearDraftSteps() {
    _draftSteps.clear();
    notifyListeners();
  }

  Future<bool> addRecipe(RecipeModel recipe) async {
    bool res = false;
    final result = await recipeAddUseCase.call(recipe);
    result.fold(
      (failure) => print('Error: $failure'),
      (ingredient) {
        res = true;
        _recipes.add(ingredient);
        notifyListeners();
      },
    );
    return res;
  }
}
