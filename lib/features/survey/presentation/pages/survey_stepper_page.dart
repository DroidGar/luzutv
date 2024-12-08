import 'package:flutter/material.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/presentation/widgets/survey_step_widget.dart';

class SurveyStepperPage extends StatefulWidget {
  static String routeName = '/survey';

  final Survey survey;

  const SurveyStepperPage({super.key, required this.survey});

  @override
  SurveyStepperPageState createState() => SurveyStepperPageState();
}

class SurveyStepperPageState extends State<SurveyStepperPage> {
  int _currentStep = 0;
  List<int?> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions = List<int?>.filled(widget.survey.steps.length, null);
  }

  void _onStepContinue() {
    if (_selectedOptions[_currentStep] != null) {
      if (_currentStep < widget.survey.steps.length - 1) {
        _currentStep++;
      } else {
        print('Survey completed');
      }
      setState(() {});
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.survey.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stepper(
            connectorColor: WidgetStateProperty.resolveWith(
              (states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey[300]!;
                }
                return const Color(0xFF71b9b7);
              },
            ),
            currentStep: _currentStep,
            onStepContinue: _onStepContinue,
            onStepCancel: _onStepCancel,
            steps: widget.survey.steps.map((step) {
              return Step(
                title: Text(step.text),
                content: SurveyStepWidget(
                  step: step,
                  onOptionSelected: (selectedOption) {
                    _selectedOptions[_currentStep] = selectedOption;
                    setState(() {});
                  },
                ),
                isActive: _currentStep == widget.survey.steps.indexOf(step),
                state:
                    _selectedOptions[widget.survey.steps.indexOf(step)] != null
                        ? StepState.complete
                        : StepState.indexed,
              );
            }).toList(),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: <Widget>[
                  const Spacer(),
                  if (_currentStep > 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Volver'),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _selectedOptions[_currentStep] != null
                        ? details.onStepContinue
                        : null,
                    child: Text(
                      _currentStep == widget.survey.steps.length - 1
                          ? 'Finalizar'
                          : 'Siguiente',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
