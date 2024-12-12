import 'package:luzu/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.uid, required super.email, super.isProfileComplete});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'];
    return UserModel(
      uid: profile['uid'],
      email: profile['email'],
      isProfileComplete: !json['ask_info'],

    );
  }
}