import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:luzu/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:luzu/features/auth/domain/entities/login_data.dart';
import 'package:luzu/features/auth/domain/entities/register_data.dart';
import 'package:luzu/features/auth/domain/entities/session.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository_base.dart';

class AuthRepository extends AuthRepositoryBase {
  final AuthRemoteDataSourceBase remote;
  final AuthLocalDataSourceBase local;

  AuthRepository(this.remote, this.local);

  @override
  Future<Either<Failure, Session>> loginOnServer(String uid) async {
    try {
      final session = await remote.loginOnServer(uid);
      await local.cacheSession(session);
      return Right(session);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnhandledFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> registerOnFirebase(RegisterData data) async {
    try {
      final uid = await remote.registerOnFirebase(data);
      return Right(uid);
    } catch (e) {
      if (e is FirebaseAuthException) return Left(UnhandledFailure(message: e.message!));
      if (e is Failure) return Left(e);
      return Left(UnhandledFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginOnFirebase(LoginData data) async {
    try {
      final uid = await remote.loginOnFirebase(data);
      return Right(uid);
    } catch (e) {
      if (e is FirebaseAuthException) return Left(UnhandledFailure(message: e.message!));
      if (e is Failure) return Left(e);
      return Left(UnhandledFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await local.clearSession();
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(UnhandledFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginOnGoogle() async {
    try {
      final uid = await remote.loginOnGoogle();
      return Right(uid);
    } catch (e) {
      if (e is FirebaseAuthException) return Left(UnhandledFailure(message: e.message!));
      if (e is Failure) return Left(e);
      return Left(UnhandledFailure(message: e.toString()));
    }
  }
}
