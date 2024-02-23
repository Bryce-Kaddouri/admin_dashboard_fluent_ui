/*
class ProductModel {
  final int id;
  final String name;
  final String? description;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isVisible;
  final double price;
  final int categoryId;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isVisible,
    required this.price,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['photo_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isVisible: json['is_visible'],
      price: json['price'],
      categoryId: json['category_id'],
    );
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
      'price': price,
      'category_id': categoryId,
    };
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isVisible,
    double? price,
    int? categoryId,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isVisible: isVisible ?? this.isVisible,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
*/

import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel{
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory UserModel.fromUser(User userData){
    return UserModel(
        id: userData.id,
      firstName: userData.userMetadata?['fName'] ?? '',
      lastName: userData.userMetadata?['lName'] ?? '',
      email: userData.email ?? '',
      role: userData.appMetadata['role'] ?? '',
      createdAt: DateTime.parse(userData.createdAt),
      updatedAt: userData.updatedAt != null ? DateTime.parse(userData.updatedAt!) : DateTime.parse(userData.createdAt),
      isActive: userData.userMetadata?['isActive'] ?? false,
    );
  }


}
