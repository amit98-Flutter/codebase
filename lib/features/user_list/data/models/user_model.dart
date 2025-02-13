import 'package:codebase/features/user_list/domain/entities/user.dart';


class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}