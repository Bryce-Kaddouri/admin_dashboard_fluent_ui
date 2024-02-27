class CustomerModel {
  final int id;
  final String fName;
  final String lName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PhoneNumberModel phoneNumber;
  final bool isEnable;

  CustomerModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
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
        phoneNumber: PhoneNumberModel.fromJson(json),
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
      'phone_number': phoneNumber.toJson(),
      'is_enable': isEnable,
    };
  }
  Map<String, dynamic> toJsonAdd() {
    return {
      'f_name': fName,
      'l_name': lName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'phone_number': phoneNumber.toJson(),
      'is_enable': isEnable,
    };
  }
}

class PhoneNumberModel {
  final String countryCode;
  final String number;

  PhoneNumberModel({
    required this.countryCode,
    required this.number,
  });

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) {
    return PhoneNumberModel(
      countryCode: json['country_code'],
      number: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_code': countryCode,
      'number': number,
    };
  }
}
