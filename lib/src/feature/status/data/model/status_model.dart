import 'package:flutter/material.dart';

class StatusModel {
  final int id;
  final int step;
  final String name;
  final Color color;

  StatusModel({
    required this.id,
    required this.step,
    required this.name,
    required this.color,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        id: json['status_id'],
        step: json['status_step'],
        name: json['status_name'],
        color: Color.fromRGBO(json['status_color_red'],
            json['status_color_green'], json['status_color_blue'], 1),
      );

  Map<String, dynamic> toJson() => {
        'status_id': id,
        'status_step': step,
        'status_name': name,
        'status_color_red': color.red,
        'status_color_green': color.green,
        'status_color_blue': color.blue,
      };
}
