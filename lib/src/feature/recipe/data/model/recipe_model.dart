import '../../../ingredient/data/model/ingredient_model.dart';

class RecipeModel {
  final int id;
  final String name;
  final DateTime? createdAt;
  final String? photoUrl;
  final String description;
  final List<RecipeStepModel> steps;
  final List<RecipeIngredientModel> ingredients;
  final List<int> productIds;

  RecipeModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.photoUrl,
    required this.description,
    required this.steps,
    required this.ingredients,
    required this.productIds,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    List<RecipeStepModel> steps = [];
    List<RecipeIngredientModel> ingredients = [];
    List<int> productIds = [];

    for (Map<String, dynamic> step in json['steps']) {
      steps.add(RecipeStepModel.fromJson(step));
    }

    for (Map<String, dynamic> ingredient in json['ingredients']) {
      ingredients.add(RecipeIngredientModel.fromJson(ingredient));
    }

    for (int product in json['product_ids'] ?? []) {
      productIds.add(product);
    }

    return RecipeModel(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photo_url'] ?? '',
      description: json['description'],
      steps: steps,
      ingredients: ingredients,
      productIds: productIds,
    );
  }

  Map<String, dynamic> toJson({required bool isToAdd}) {
    List<Map<String, dynamic>> steps = [];
    List<Map<String, dynamic>> ingredients = [];
    List<int> productIds = [];

    for (RecipeStepModel step in this.steps) {
      steps.add(step.toJson(isToAdd: isToAdd));
    }

    for (RecipeIngredientModel ingredient in this.ingredients) {
      ingredients.add(ingredient.toJson(isToAdd: isToAdd, recipeId: id));
    }

    for (int product in this.productIds) {
      productIds.add(product);
    }

    if (isToAdd) {
      return {
        'name': name,
        'photo_url': photoUrl,
        'description': description,
      };
    }
    return {
      'id': id,
      'name': name,
      'photo_url': photoUrl,
      'description': description,
      'steps': steps,
      'ingredients': ingredients,
      'product_ids': productIds,
    };
  }
}

class RecipeStepModel {
  final String description;
  final int stepNumber;

  RecipeStepModel({
    required this.description,
    required this.stepNumber,
  });

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) {
    return RecipeStepModel(
      description: json['description'],
      stepNumber: json['step_number'],
    );
  }

  Map<String, dynamic> toJson({required bool isToAdd}) {
    return {
      'description': description,
      'step_number': stepNumber,
    };
  }
}

class RecipeIngredientModel {
  final int? ingredientId;
  final String? name;
  final double quantity;
  final String unit;
  final String? photoUrl;

  RecipeIngredientModel({
    this.ingredientId,
    this.name,
    required this.quantity,
    required this.unit,
    this.photoUrl,
  });

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientModel(
      name: json['name'],
      quantity: json['quantity'],
      unit: json['measurement_unit'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson({required bool isToAdd, required int recipeId}) {
    if (isToAdd) {
      return {
        'recipe_id': recipeId,
        'ingredient_id': ingredientId,
        'quantity': quantity,
        'measurement_unit': unit,
      };
    }
    return {
      'recipe_id': recipeId,
      'ingredient_id': ingredientId,
      'name': name,
      'quantity': quantity,
      'measurement_unit': unit,
      'photo_url': photoUrl ?? '',
    };
  }
}

enum SolidUnit {
  mg,
  cg,
  dg,
  g,
  dag,
  hg,
  kg,
}

enum LiquidUnit {
  ml,
  cl,
  dl,
  l,
}

enum NumberUnit {
  unit,
}

class IngredientUnitImpl {
  static String getUnitName(IngredientType type, int index) {
    switch (type) {
      case IngredientType.solid:
        return SolidUnit.values[index].toString().split('.').last;
      case IngredientType.liquid:
        return LiquidUnit.values[index].toString().split('.').last;
      case IngredientType.number:
        return NumberUnit.values[index].toString().split('.').last;
    }
  }

  static List<String> getUnits(IngredientType type) {
    switch (type) {
      case IngredientType.solid:
        return SolidUnit.values.map((e) => e.toString().split('.').last).toList();
      case IngredientType.liquid:
        return LiquidUnit.values.map((e) => e.toString().split('.').last).toList();
      case IngredientType.number:
        return NumberUnit.values.map((e) => e.toString().split('.').last).toList();
    }
  }
}
