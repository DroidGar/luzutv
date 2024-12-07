import 'package:flutter/material.dart';

class SurveyWidget extends StatelessWidget {
  const SurveyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ElevatedButton(onPressed: () => {}, child: Text("Encuesta")),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              "Que te parece el origen de Luzu Tv?",
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
}
