import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:luzu/features/survey/data/datasource/survey_remote_data_source.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/domain/repositories/survey_repository_base.dart';

class SurveyRepository extends SurveyRepositoryBase {
  final SurveyRemoteDataSourceBase remote;

  SurveyRepository(this.remote);

  @override
  Future<Either<Failure, Survey>> load() async {
    try {
      final survey = await remote.load();
      return Right(survey);
    } catch (e) {
      return Left(UnhandledFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Survey>> save(Survey survey) async {
    try {
      final savedSurvey = await remote.save(survey);
      return Right(savedSurvey);
    } catch (e) {
      return Left(UnhandledFailure(message: e.toString()));
    }
  }
}
