import 'package:luzu/features/survey/domain/entities/survey_option.dart';

abstract class SurveyStep {
  final int id;
  final String text;
  final List<SurveyOption> options;

  SurveyStep({required this.id, required this.text, required this.options});

  Map toJson();
}
