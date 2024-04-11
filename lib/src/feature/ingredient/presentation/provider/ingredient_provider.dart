import 'package:admin_dashboard/src/feature/ingredient/business/usecase/ingredient_add_usecase.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/model/ingredient_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../../business/usecase/ingredient_get_ingredients_usecase.dart';

class IngredientProvider with ChangeNotifier {
  final IngredientGetIngredientsUseCase ingredientGetIngredientsUseCase;
  final IngredientAddUseCase ingredientAddUseCase;

  IngredientProvider({
    required this.ingredientGetIngredientsUseCase,
    required this.ingredientAddUseCase,
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

  List<IngredientModel> _ingredients = [];
  List<IngredientModel> get ingredients => _ingredients;

  Future<void> getIngredients() async {
    final result = await ingredientGetIngredientsUseCase.call(NoParams());
    result.fold(
      (failure) => print('Error: $failure'),
      (ingredients) {
        _ingredients = ingredients;
        notifyListeners();
      },
    );
  }

  Future<bool> addIngredient(IngredientModel ingredient) async {
    bool res = false;
    final result = await ingredientAddUseCase.call(ingredient);
    result.fold(
      (failure) => print('Error: $failure'),
      (ingredient) {
        res = true;
        _ingredients.add(ingredient);
        notifyListeners();
      },
    );
    return res;
  }
}
