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
    final products = json['product_ids'] ?? [];
    for (int product in products) {
      productIds.add(product);
    }

    return RecipeModel(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photo_url'] ?? '',
      description: json['description'] ?? '',
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
  final String? unit;
  final String? photoUrl;
  final IngredientType? type;

  RecipeIngredientModel({
    this.ingredientId,
    this.name,
    required this.quantity,
    this.unit,
    this.photoUrl,
    this.type,
  });

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    int indexType = json['type'] - 1;
    return RecipeIngredientModel(
      name: json['name'],
      quantity: double.parse(json['quantity'].toString()),
      photoUrl: json['photo_url'] ?? '',
      type: IngredientType.values[indexType],
      ingredientId: json['id'],
    );
  }

  Map<String, dynamic> toJson({required bool isToAdd, required int recipeId}) {
    if (isToAdd) {
      return {
        'recipe_id': recipeId,
        'ingredient_id': ingredientId,
        'quantity': quantity,
      };
    }
    return {
      'recipe_id': recipeId,
      'ingredient_id': ingredientId,
      'name': name,
      'quantity': quantity,
      'photo_url': photoUrl ?? '',
    };
  }

  static String getUnit(double qty, IngredientType type) {
    if (type == IngredientType.solid) {
      // check the first one where is > to 0
      switch (SolidUnit.values.firstWhere((e) => convertToGram(qty, type, e.toString().split('.').last) > 0)) {
        case SolidUnit.mg:
          return SolidUnit.mg.toString().split('.').last;
        case SolidUnit.cg:
          return SolidUnit.cg.toString().split('.').last;
        case SolidUnit.dg:
          return SolidUnit.dg.toString().split('.').last;
        case SolidUnit.g:
          return SolidUnit.g.toString().split('.').last;
        case SolidUnit.dag:
          return SolidUnit.dag.toString().split('.').last;
        case SolidUnit.hg:
          return SolidUnit.hg.toString().split('.').last;
        case SolidUnit.kg:
          return SolidUnit.kg.toString().split('.').last;
      }
    } else if (type == IngredientType.liquid) {
      // check the first one where is > to 0
      switch (LiquidUnit.values.firstWhere((e) => convertToGram(qty, type, e.toString().split('.').last) > 0)) {
        case LiquidUnit.ml:
          return LiquidUnit.ml.toString().split('.').last;
        case LiquidUnit.cl:
          return LiquidUnit.cl.toString().split('.').last;
        case LiquidUnit.dl:
          return LiquidUnit.dl.toString().split('.').last;
        case LiquidUnit.l:
          return LiquidUnit.l.toString().split('.').last;
        case LiquidUnit.dal:
          return LiquidUnit.dal.toString().split('.').last;
        case LiquidUnit.hl:
          return LiquidUnit.hl.toString().split('.').last;
        case LiquidUnit.kl:
          return LiquidUnit.kl.toString().split('.').last;
      }
    } else {
      return NumberUnit.unit.toString().split('.').last;
    }
  }

  static double convertToGram(double qty, IngredientType type, String unit) {
    // check if solid or liquid or number
    if (type == IngredientType.solid) {
      // check the measurement unit
      SolidUnit solidUnit = SolidUnit.values.firstWhere((e) => e.toString() == 'SolidUnit.${unit}');
      if (solidUnit == SolidUnit.mg) {
        // mg --> g
        qty = qty / 1000;
      } else if (solidUnit == SolidUnit.cg) {
        // cg --> g
        qty = qty / 100;
      } else if (solidUnit == SolidUnit.dg) {
        // dg --> g
        qty = qty / 10;
      } else if (solidUnit == SolidUnit.g) {
        // g
      } else if (solidUnit == SolidUnit.dag) {
        // dag --> g
        qty = qty * 10;
      } else if (solidUnit == SolidUnit.hg) {
        // hg --> g
        qty = qty * 100;
      } else {
        // kg --> g
        qty = qty * 1000;
      }
    } else if (type == IngredientType.liquid) {
      // liquid
      LiquidUnit liquidUnit = LiquidUnit.values.firstWhere((e) => e.toString() == 'LiquidUnit.${unit!}');
      if (liquidUnit == LiquidUnit.ml) {
        // ml --> l
        qty = qty / 1000;
      } else if (liquidUnit == LiquidUnit.cl) {
        // cl --> l
        qty = qty / 100;
      } else if (liquidUnit == LiquidUnit.dl) {
        // dl --> l
        qty = qty / 10;
      } else if (liquidUnit == LiquidUnit.l) {
        // l --> l
        qty = qty * 1000;
      } else if (liquidUnit == LiquidUnit.dal) {
        // dal --> l
        qty = qty * 10;
      } else if (liquidUnit == LiquidUnit.hl) {
        // hl --> l
        qty = qty * 100;
      } else {
        // kl --> l
        qty = qty * 1000;
      }
    } else {
      // number
      qty = qty;
    }

    return qty;
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
  dal,
  hl,
  kl,
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
