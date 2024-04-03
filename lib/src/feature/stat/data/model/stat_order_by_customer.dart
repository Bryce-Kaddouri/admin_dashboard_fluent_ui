class StatOrderByCustomer {
  final int count;
  final int idCustomer;
  final String fNameCustomer;
  final String lNameCustomer;

  final String phoneCustomer;

  StatOrderByCustomer({
    required this.count,
    required this.idCustomer,
    required this.fNameCustomer,
    required this.lNameCustomer,
    required this.phoneCustomer,
  });

  factory StatOrderByCustomer.fromJson(Map<String, dynamic> json) {
    return StatOrderByCustomer(
      count: json['count'],
      idCustomer: json['customer_id'],
      fNameCustomer: json['customer_f_name'],
      lNameCustomer: json['customer_l_name'],
      phoneCustomer: json['customer_phone_number'],
    );
  }
}
