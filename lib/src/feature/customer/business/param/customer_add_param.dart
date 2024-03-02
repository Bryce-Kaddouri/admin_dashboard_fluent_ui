class CustomerAddParam {
  final String fName;
  final String lName;
  final String phoneNumber;
  final String countryCode;
  final bool isEnable;

  CustomerAddParam({
    required this.fName,
    required this.lName,
    required this.phoneNumber,
    required this.countryCode,
    required this.isEnable,
  });

  Map<String, dynamic> toJson() {
    return {
      'f_name': fName,
      'l_name': lName,
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'is_enable': isEnable,
    };
  }
}
