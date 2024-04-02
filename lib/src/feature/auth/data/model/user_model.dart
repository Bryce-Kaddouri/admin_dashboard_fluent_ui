// user model means the employee model
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String uid;
  final String fName;
  final String lName;
  final String? email;

  UserModel({
    required this.uid,
    required this.fName,
    required this.lName,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['user_id'],
        fName: json['user_full_name']['fName'],
        lName: json['user_full_name']['lName'],
      );

  factory UserModel.fromUser(User user) => UserModel(
        uid: user.id,
        fName: user.userMetadata!['fName'] as String? ?? '', // if null, then return '
        lName: user.userMetadata!['lName'] as String? ?? '', // if null, then return '
        email: user.email,
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'user_full_name': {
          'fName': fName,
          'lName': lName,
        },
      };
}
