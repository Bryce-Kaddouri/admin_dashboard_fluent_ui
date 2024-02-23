class StatOrderByCategoryModel {
  final int idCategory;
  String nameCategory;
  final double total_quantity;

  StatOrderByCategoryModel({
    required this.idCategory,
    required this.nameCategory,
    required this.total_quantity,
  });

  factory StatOrderByCategoryModel.fromJson(Map<String, dynamic> json) {
    return StatOrderByCategoryModel(
      idCategory: json['id'],
      nameCategory: json['name'],
      total_quantity: json['total_quantity'],
    );
  }
}