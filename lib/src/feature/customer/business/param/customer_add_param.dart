import '../../data/model/customer_model.dart';

class CustomerAddParam {
  final String fName;
  final String lName;
  final PhoneNumberModel phoneNumber;
  final bool isEnable;

  CustomerAddParam({
    required this.fName,
    required this.lName,
    required this.phoneNumber,
    required this.isEnable,
  });

  Map<String, dynamic> toJson() {
    return {
      'f_name': fName,
      'l_name': lName,
      'phone_number': phoneNumber.number,
      'country_code': phoneNumber.countryCode,
      'is_enable': isEnable,
    };
  }
}
