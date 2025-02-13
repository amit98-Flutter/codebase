import 'package:equatable/equatable.dart';

class User extends Equatable  {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, avatar];
}