import 'package:flutter/material.dart';
import 'package:luzu/features/survey/domain/entities/survey_step.dart';

class SurveyStepWidget extends StatefulWidget {
  final SurveyStep step;
  final ValueChanged<int> onOptionSelected;

  const SurveyStepWidget({
    super.key,
    required this.step,
    required this.onOptionSelected,
  });

  @override
  SurveyStepWidgetState createState() => SurveyStepWidgetState();
}

class SurveyStepWidgetState extends State<SurveyStepWidget> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widget.step.options.asMap().entries.map((entry) {
          int index = entry.key;
          var option = entry.value;
          return RadioListTile<int>(
            title: Text(option.value),
            value: index,
            groupValue: _selectedOption,
            onChanged: (value) {
              _selectedOption = value;
              setState(() {});
              widget.onOptionSelected(value!);
            },
          );
        }),
      ],
    );
  }
}
