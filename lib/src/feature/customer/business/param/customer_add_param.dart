import '../../data/model/customer_model.dart';

class CustomerAddParam {
  final String fName;
  final String lName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PhoneNumberModel phoneNumber;
  final bool isEnable;

  CustomerAddParam({
    required this.fName,
    required this.lName,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.isEnable,
  });

  Map<String, dynamic> toJson() {
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
