import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/entities/user.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository_base.dart';

class Me {
  final AuthRepositoryBase _authRepository;

  Me(this._authRepository);

  Future<Either<Failure, User>> call() async {
    return await _authRepository.me();
  }
}