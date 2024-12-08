import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/entities/login_data.dart';
import 'package:luzu/features/auth/domain/entities/register_data.dart';
import 'package:luzu/features/auth/domain/entities/session.dart';

abstract class AuthRepositoryBase {
  Future<Either<Failure, Session>> loginOnServer(String uid);
  Future<Either<Failure, String>> loginOnFirebase(LoginData data);
  Future<Either<Failure, String>> loginOnGoogle();
  Future<Either<Failure, String>> registerOnFirebase(RegisterData data);
  Future<Either<Failure, void>> logout();
}
