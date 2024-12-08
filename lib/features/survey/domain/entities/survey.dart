import 'package:luzu/features/survey/domain/entities/survey_step.dart';

abstract class Survey {
  final String title;
  final String description;
  final List<SurveyStep> steps;

  Survey({required this.title, required this.description, required this.steps});
}
