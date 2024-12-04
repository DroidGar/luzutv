import 'package:luzu/features/auth/domain/entities/register_data.dart';

class RegisterDataModel extends RegisterData {
  RegisterDataModel({
    required super.email,
    required super.password,
  });

  factory RegisterDataModel.fromJson(Map<String, dynamic> json) {
    return RegisterDataModel(
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