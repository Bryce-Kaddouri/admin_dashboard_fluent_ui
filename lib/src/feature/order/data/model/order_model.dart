import 'package:flutter/material.dart';

import '../../../auth/data/model/user_model.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../customer/data/model/customer_model.dart';
import '../../../status/data/model/status_model.dart';

class OrderModel {
  final int? id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? cookingAt;
  final DateTime? readyAt;
  final DateTime? collectedAt;
  final DateTime date;
  final TimeOfDay time;

  final CustomerModel customer;
  final StatusModel status;
  final UserModel user;

  final List<CartModel> cart;
  final double totalAmount;
  final double paidAmount;
  final String orderNote;

  OrderModel({
    this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.time,
    required this.customer,
    required this.status,
    required this.user,
    required this.cart,
    required this.totalAmount,
    required this.paidAmount,
    required this.orderNote,
    this.cookingAt,
    this.readyAt,
    this.collectedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    /* List<dynamic> cart =
        json['cart']['cart_items'];
    print(cart);
    String cartString = cart.toString();
    var test = jsonEncode(cart);
    print(test);
    var test2 = jsonDecode(test);*/
    /* print('*' * 50);
    print(test2);*/

    /*List<Map<String, dynamic>> jsonCart =
        json['cart']['cart_items'].cast<Map<String, dynamic>>();

*/

    return OrderModel(
      id: json['order_id'],
      createdAt: DateTime.parse(json['order_created_at']),
      updatedAt: DateTime.parse(json['order_updated_at']),
      date: DateTime.parse(json['order_date']),
      time: TimeOfDay(
        hour: int.parse(json['order_time'].split(':')[0]),
        minute: int.parse(json['order_time'].split(':')[1]),
      ),
      /*json['order_is_paid'],*/
      customer: CustomerModel.fromJson(json['customer']),
      status: StatusModel.fromJson(json['status']),
      user: UserModel.fromJson(json['user']),
      cart: List<CartModel>.from(json['cart'].map((x) => CartModel.fromJson(x))),
      totalAmount: double.parse(json['total_amount'].toString()),
      paidAmount: double.parse(json['order_amount_paid'].toString()),
      orderNote: json['order_note'] ?? '',
      cookingAt: json['order_cooking_date'] != null ? DateTime.parse(json['order_cooking_date']) : null,
      readyAt: json['order_ready_date'] != null ? DateTime.parse(json['order_ready_date']) : null,
      collectedAt: json['order_collected_date'] != null ? DateTime.parse(json['order_collected_date']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'date': date.toIso8601String(),
        'time': '${time.hour}:${time.minute}',
        'customer': customer.toJson(),
        /* 'status': status.toJson(),
        'user': user.toJson(),
        'cart': cart.map((e) => e.toJson()).toList(),*/
      };
}
