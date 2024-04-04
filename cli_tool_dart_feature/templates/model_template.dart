class FeatureNameModel {
  final String id;
  final String name;

  FeatureNameModel({
    required this.id,
    required this.name,
  });

  factory FeatureNameModel.fromJson(Map<String, dynamic> json) {
    return FeatureNameModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
