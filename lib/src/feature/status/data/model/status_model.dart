class StatusModel {
  final int id;
  final int step;
  final String name;

  StatusModel({
    required this.id,
    required this.step,
    required this.name,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        id: json['status_id'],
        step: json['status_step'],
        name: json['status_name'],
      );

  Map<String, dynamic> toJson() => {
        'status_id': id,
        'status_step': step,
        'status_name': name,
      };
}
