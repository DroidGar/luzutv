import 'package:dartz/dartz.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:luzu/features/survey/data/datasource/survey_remote_data_source.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/domain/repositories/survey_repository_base.dart';

class SurveyRepository extends SurveyRepositoryBase {
  final SurveyRemoteDataSourceBase remote;
  final AuthLocalDataSourceBase local;

  SurveyRepository(this.remote, this.local);

  @override
  Future<Either<Failure, Survey>> load() async {
    try {
      final session = await local.getSession();
      final survey = await remote.load(session);
      return Right(survey);
    } catch (e) {
      return Left(UnhandledFailure(message: e.toString()));
    }
  }
}
