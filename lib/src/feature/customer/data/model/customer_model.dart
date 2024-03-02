class CustomerModel {
  final int id;
  final String fName;
  final String lName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String phoneNumber;
  final String countryCode;
  final bool isEnable;

  CustomerModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.countryCode,
    required this.isEnable,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    try {
      return CustomerModel(
        id: json['id'],
        fName: json['f_name'],
        lName: json['l_name'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        phoneNumber: json['phone_number'],
        countryCode: json['country_code'],
        isEnable: json['is_enable'],
      );
    } catch (e) {
      throw Exception('Error parsing customer model');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'l_name': lName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'is_enable': isEnable,
    };
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      'f_name': fName,
      'l_name': lName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'is_enable': isEnable,
    };
  }
}
