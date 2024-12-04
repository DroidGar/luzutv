import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/entities/login_data.dart';
import 'package:luzu/features/auth/domain/entities/register_data.dart';
import 'package:luzu/features/auth/domain/entities/session.dart';
import 'package:http/http.dart';
import 'package:luzu/main.dart';

abstract class AuthRemoteDataSource {
  Future<Session> loginOnServer(String uid);

  Future<String> loginOnFirebase(LoginData data);

  Future<String> registerOnFirebase(RegisterData data);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Client http;
  final FirebaseAuth auth;

  AuthRemoteDataSourceImpl(this.http, this.auth);

  @override
  Future<Session> loginOnServer(String uid) async {
    final result = await http.post(
      Uri.parse('$host/login'),
      body: jsonEncode({'uid': uid}),
    );
    return tryGetTokenFromResponse(result);
  }

  @override
  Future<String> registerOnFirebase(RegisterData data) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: data.email,
      password: data.password,
    );
    return userCredential.user!.uid;
  }

  Session tryGetTokenFromResponse(Response response) {
    if (response.statusCode == 200) {
      final payload = jsonDecode(response.body);
      if (payload['status'] != 'ok') {
        throw UnhandledFailure(message: payload['message']);
      }
      return payload['message'];
    }
    throw UnhandledFailure(message: 'Error on request');
  }

  @override
  Future<String> loginOnFirebase(LoginData data) async {
      final result = await auth.signInWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      return result.user!.uid;
  }
}
