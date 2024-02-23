class CategoryModel {
  final int id;
  final String name;
  final String? description;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isVisible;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isVisible,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return CategoryModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['photo_url'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        isVisible: json['is_visible'],
      );
    } catch (e) {
      print(e);
      return CategoryModel(
        id: 0,
        name: '',
        description: '',
        imageUrl: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVisible: false,
      );
    }

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photo_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_visible': isVisible,
    };
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isVisible,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
