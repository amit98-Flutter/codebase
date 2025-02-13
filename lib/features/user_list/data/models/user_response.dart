import 'package:codebase/features/user_list/data/models/user_model.dart';

class UserResponse {
  final List<UserModel> users;
  final int total;

  UserResponse({required this.users, required this.total});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      users: (json["data"] as List).map((e) => UserModel.fromJson(e)).toList(),
      total: json["total"],
    );
  }
}