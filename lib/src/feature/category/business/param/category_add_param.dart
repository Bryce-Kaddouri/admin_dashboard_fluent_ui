import 'dart:typed_data';

class CategoryAddParam {
  final String name;
  final String? description;
  final String imageUrl;

  CategoryAddParam({
    required this.name,
    this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'photo_url': imageUrl,
    };
    if (description != null) {
      map['description'] = description;
    }
    return map;
  }
}
