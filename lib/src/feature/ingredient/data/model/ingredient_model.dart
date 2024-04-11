enum IngredientType {
  liquid,
  solid,
  number,
}

class IngredientModel {
  final int id;
  DateTime createdAt;
  String name;
  String? photoUrl;
  IngredientType type;

  IngredientModel({
    required this.id,
    required this.createdAt,
    required this.name,
    this.photoUrl,
    required this.type,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    int ingredientType = json['ingredient_type_id'];
    return IngredientModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      photoUrl: json['photo_url'],
      type: IngredientType.values[ingredientType - 1],
    );
  }

  Map<String, dynamic> toJson({bool isToAdd = false}) {
    print(type.index);
    if (isToAdd) {
      return {
        'created_at': createdAt.toIso8601String(),
        'name': name,
        'photo_url': photoUrl,
        'ingredient_type_id': type.index + 1,
      };
    }
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'photo_url': photoUrl,
      'ingredient_type_id': type.index + 1,
    };
  }
}
