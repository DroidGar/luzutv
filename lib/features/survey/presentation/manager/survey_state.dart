part of 'survey_cubit.dart';

@immutable
sealed class SurveyState {}

final class SurveyInitial extends SurveyState {}

final class SurveyLoading extends SurveyState {}

final class SurveyLoaded extends SurveyState {
  final Survey survey;

  SurveyLoaded(this.survey);
}

final class SurveyFailure extends SurveyState {
  final Failure failure;

  SurveyFailure(this.failure);
}
