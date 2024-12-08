import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/domain/repositories/survey_repository_base.dart';

class SaveSurvey {
  final SurveyRepositoryBase repository;

  SaveSurvey(this.repository);

  Future<Either<Failure, Survey>> call(survey) async {
    return await repository.save(survey);
  }
}
