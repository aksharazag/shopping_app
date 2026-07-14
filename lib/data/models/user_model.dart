import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.email, required super.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json['email'],
    password: json['password'],
  );
}
