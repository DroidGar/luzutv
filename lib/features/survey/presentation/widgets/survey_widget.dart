import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/core/services/di_service.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/presentation/manager/survey_cubit.dart';

class SurveyWidget extends StatefulWidget {
  const SurveyWidget({super.key});

  @override
  State<SurveyWidget> createState() => _SurveyWidgetState();
}

class _SurveyWidgetState extends State<SurveyWidget> {
  Survey? survey;
  final _cubit = getIt<SurveyCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.actionLoadSurvey();

    _cubit.stream.listen((state) {
      if (state is SurveyLoaded) {
        survey = state.survey;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (survey == null) {
      return const SizedBox();
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => _navigateToSurvey(context),
            child: const Text("Encuesta"),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              survey!.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSurvey(BuildContext context) {
    context.push('/survey', extra: survey);
  }
}
