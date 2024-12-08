abstract class SurveyOption {
  final int id;
  final String value;
  final String type;

  SurveyOption({
    required this.id,
    required this.value,
    required this.type
  });

  Map toJson();
}
