import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/entities/login_data.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository_base.dart';

class LoginOnFirebase {
  final AuthRepositoryBase _authRepository;

  LoginOnFirebase(this._authRepository);

  Future<Either<Failure, String>> call(LoginData data) async {
    return await _authRepository.loginOnFirebase(data);
  }



}
