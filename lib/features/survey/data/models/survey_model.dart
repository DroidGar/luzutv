import 'package:luzu/features/survey/data/models/survey_step_model.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/domain/entities/survey_step.dart';

class SurveyModel extends Survey {
  SurveyModel({
    required super.title,
    required super.description,
    required super.steps,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      title: json['title'],
      description: json['description'],
      steps: json['questions']
          .map<SurveyStep>((step) => SurveyStepModel.fromJson(step))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'questions': steps.map((step) => step.toJson()).toList(),
    };
  }
}
