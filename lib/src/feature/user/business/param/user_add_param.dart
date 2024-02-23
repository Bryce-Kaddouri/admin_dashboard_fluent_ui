class UserAddParam {
  final String email;
  final String password;
  final String fName;
  final String lName;
  final bool isAvailable;
  String role;

  UserAddParam({
    required this.email,
    required this.password,
    required this.fName,
    required this.lName,
    required this.isAvailable,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'first_name': fName,
      'last_name': lName,
      'is_available': isAvailable,
      'role': role,
    };
  }
}
