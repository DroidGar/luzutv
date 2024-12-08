import 'package:bloc/bloc.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/domain/use_cases/load_survey.dart';
import 'package:meta/meta.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  final LoadSurvey loadSurvey;

  SurveyCubit(this.loadSurvey) : super(SurveyInitial());

  void actionLoadSurvey() async {
    emit(SurveyLoading());
    final result = await loadSurvey();
    result.fold(
      (failure) => emit(SurveyFailure(failure)),
      (survey) => emit(SurveyLoaded(survey)),
    );
  }
}
