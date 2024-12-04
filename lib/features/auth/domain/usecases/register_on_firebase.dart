import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/entities/register_data.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository.dart';

class RegisterOnFirebase {
  final AuthRepository repository;

  RegisterOnFirebase(this.repository);

  Future<Either<Failure, String>> call(RegisterData data) async {
    return await repository.registerOnFirebase(data);
  }
}