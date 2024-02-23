class StatOrderByCustomer {
  final int count;
  final int idCustomer;
  final String fNameCustomer;
  final String lNameCustomer;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String phoneCustomer;

  StatOrderByCustomer({
    required this.count,
    required this.idCustomer,
    required this.fNameCustomer,
    required this.lNameCustomer,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneCustomer,
  });

  factory StatOrderByCustomer.fromJson(Map<String, dynamic> json) {
    return StatOrderByCustomer(
      count: json['count'],
      idCustomer: json['id'],
      fNameCustomer: json['f_name'],
      lNameCustomer: json['l_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      phoneCustomer: json['phone_number'],
    );
  }
}