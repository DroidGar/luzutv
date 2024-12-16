import 'package:luzu/features/survey/data/models/survey_option_model.dart';
import 'package:luzu/features/survey/domain/entities/survey_option.dart';
import 'package:luzu/features/survey/domain/entities/survey_step.dart';

class SurveyStepModel extends SurveyStep {
  SurveyStepModel({
    required super.id,
    required super.text,
    required super.options,
  });

  factory SurveyStepModel.fromJson(Map<String, dynamic> json) {
    return SurveyStepModel(
      id: int.parse(json['id'].toString()),
      text: json['question'],
      options: json['options']
          .map<SurveyOption>((option) => SurveyOptionModel.fromJson(option))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'selected_option_id': selectedOption,
    };
  }
}
