import 'package:luzu/features/auth/domain/entities/login_data.dart';

class LoginDataModel extends LoginData {
  LoginDataModel({
    required super.email,
    required super.password,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}