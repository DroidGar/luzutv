import 'package:luzu/features/survey/domain/entities/survey_option.dart';

class SurveyOptionModel extends SurveyOption {
  SurveyOptionModel({
    required super.id,
    required super.value,
    required super.type,
  });

  factory SurveyOptionModel.fromJson(Map<String, dynamic> json) {
    return SurveyOptionModel(
      id: json['id'],
      value: json['value'],
      type: json['type'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'type': type,
    };
  }
}
