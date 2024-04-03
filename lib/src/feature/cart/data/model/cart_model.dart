import '../../../product/data/model/product_model.dart';

class CartModel {
  final int? id;
  int quantity;
  final bool isDone;
  final ProductModel product;

  CartModel({
    this.id,
    required this.quantity,
    required this.isDone,
    required this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json, {bool isFromTable = true}) => CartModel(
        id: json['cart_id'],
        quantity: json['quantity'],
        isDone: json['is_done'],
        product: ProductModel.fromJson(json['product_info'], isFromTable: isFromTable),
      );

  Map<String, dynamic> toJson() => {
        'cart_id': id,
        'quantity': quantity,
        'is_done': isDone,
        'product_info': product.toJson(),
      };

  // method to check if two cart models are equal by using assert
}
