import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/entities/session.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository_base.dart';

class LoginOnServer {
  final AuthRepositoryBase _authRepository;

  LoginOnServer(this._authRepository);

  Future<Either<Failure, Session>> call(String uid) async {
    return await _authRepository.loginOnServer(uid);
  }



}
