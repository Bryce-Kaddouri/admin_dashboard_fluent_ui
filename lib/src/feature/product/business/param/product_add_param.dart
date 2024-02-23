class ProductAddParam {
  final String name;
  final String? description;
  final String imageUrl;
  final double price;
  final int categoryId;

  ProductAddParam({
    required this.name,
    this.description,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'photo_url': imageUrl,
      'price': price,
      'category_id': categoryId,
    };
    if (description != null) {
      map['description'] = description;
    }
    return map;
  }
}
