import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';

abstract class SurveyRepositoryBase {
  Future<Either<Failure, Survey>> load();

  Future<Either<Failure, Survey>> save(Survey survey);
}
