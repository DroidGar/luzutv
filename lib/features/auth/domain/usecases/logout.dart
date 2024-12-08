import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository_base.dart';

class Logout {
  final AuthRepositoryBase _authRepository;

  Logout(this._authRepository);

  Future<Either<Failure, void>> call() async {
    return await _authRepository.logout();
  }
}