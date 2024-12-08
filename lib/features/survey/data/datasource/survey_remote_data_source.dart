import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:luzu/features/auth/domain/entities/session.dart';
import 'package:luzu/features/survey/data/models/survey_model.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/main.dart';

abstract class SurveyRemoteDataSourceBase {
  Future<Survey> load(Session session);
}

class SurveyRemoteDataSource implements SurveyRemoteDataSourceBase {
  final Client client;

  SurveyRemoteDataSource(this.client);

  @override
  Future<Survey> load(Session session) async {
    final response = await client.get(
      Uri.parse('$host/survey'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.token}'},
    );
    if (response.statusCode == 200) {
      return SurveyModel.fromJson(jsonDecode(response.body)["survey"]);
    } else {
      throw Exception('Failed to load survey');
    }
  }
}
