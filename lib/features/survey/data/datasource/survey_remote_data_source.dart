import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:luzu/features/survey/data/models/survey_model.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/main.dart';

abstract class SurveyRemoteDataSourceBase {
  Future<Survey> load();

  Future<Survey> save(Survey survey);
}

class SurveyRemoteDataSource implements SurveyRemoteDataSourceBase {
  final Client client;

  SurveyRemoteDataSource(this.client);

  @override
  Future<Survey> load() async {
    final response = await client.get(Uri.parse('$host/survey'));
    if (response.statusCode == 200) {
      return SurveyModel.fromJson(jsonDecode(response.body)["survey"]);
    } else {
      throw Exception('Failed to load survey');
    }
  }

  @override
  Future<Survey> save(Survey survey) async {
    print(survey.toJson());
    final response = await client.post(
      Uri.parse('$host/survey'),
      body: jsonEncode(survey.toJson()),
    );
    if (response.statusCode == 200) {
      return SurveyModel.fromJson(jsonDecode(response.body)["survey"]);
    } else {
      throw Exception('Failed to save survey');
    }
  }
}
