import 'package:bloc/bloc.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/domain/use_cases/load_survey.dart';
import 'package:luzu/features/survey/domain/use_cases/save_survey.dart';
import 'package:meta/meta.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  final LoadSurvey loadSurvey;
  final SaveSurvey saveSurvey;

  SurveyCubit(this.loadSurvey, this.saveSurvey) : super(SurveyInitial());

  void actionLoadSurvey() async {
    emit(SurveyLoading());
    final result = await loadSurvey();
    result.fold(
      (failure) => emit(SurveyFailure(failure)),
      (survey) {
        if (survey == null) return;
        emit(SurveyLoaded(survey));
      },
    );
  }

  void actionSaveSurvey(Survey survey) async {
    emit(SurveySaving());
    final result = await saveSurvey(survey);
    result.fold(
      (failure) => emit(SurveyFailure(failure)),
      (survey) => emit(SurveySaved(survey)),
    );
  }
}
