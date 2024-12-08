import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/entities/register_data.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository_base.dart';

class LoginWithGoogle {
  final AuthRepositoryBase repository;

  LoginWithGoogle(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.loginOnGoogle();
  }
}
