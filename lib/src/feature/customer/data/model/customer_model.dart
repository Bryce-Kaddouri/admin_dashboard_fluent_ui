import 'package:phone_form_field/phone_form_field.dart';

class CustomerModel {
  final int id;
  final String fName;
  final String lName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String phoneNumber;
  final String countryCode;
  final bool isEnable;
  final IsoCode? isoCode;

  CustomerModel(
      {required this.id,
      required this.fName,
      required this.lName,
      this.createdAt,
      this.updatedAt,
      required this.phoneNumber,
      required this.countryCode,
      required this.isEnable,
      this.isoCode});

  factory CustomerModel.fromJson(Map<String, dynamic> json,
      {bool isFromTable = true}) {
    try {
      if (isFromTable) {
        return CustomerModel(
            id: json['id'],
            fName: json['f_name'],
            lName: json['l_name'],
            phoneNumber: json['phone_number'],
            countryCode: json['country_code'],
            isEnable: json['is_enable'],
            isoCode: IsoCode.fromJson(json['iso_code']));
      } else {
        return CustomerModel(
          id: json['customer_id'],
          fName: json['customer_f_name'],
          lName: json['customer_l_name'],
          phoneNumber: json['customer_phone_number'],
          countryCode: json['customer_country_code'],
          isEnable: true,
        );
      }
    } catch (e) {
      throw Exception('Error parsing customer model');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'l_name': lName,
      'updated_at': updatedAt?.toIso8601String(),
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'is_enable': isEnable,
      'iso_code': isoCode?.name,
    };
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      'f_name': fName,
      'l_name': lName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'is_enable': isEnable,
      'iso_code': isoCode?.name,
    };
  }
}
