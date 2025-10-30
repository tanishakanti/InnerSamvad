// lib/snake_ladder/question_dialogs.dart
import 'package:flutter/material.dart';
import 'question_data.dart';

Future<bool> showQuestionDialogSet(BuildContext context, QuestionSet qSet) async {
  bool allCorrect = true;

  for (var q in qSet.questions) {
    if (q['type'] == 'input') {
      await showDialog(
        context: context,
        builder: (context) {
          TextEditingController ctrl = TextEditingController();
          return AlertDialog(
            title: Text(qSet.title),
            content: TextField(
              controller: ctrl,
              decoration: InputDecoration(labelText: q['question']),
              maxLines: 2,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Submit"),
              ),
            ],
          );
        },
      );
    } else if (q['type'] == 'mcq') {
      int? selected;
      bool correct = false;
      await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(qSet.title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(q['options'].length, (i) {
                  return RadioListTile<int>(
                    title: Text(q['options'][i]),
                    value: i,
                    groupValue: selected,
                    onChanged: (val) => setState(() => selected = val),
                  );
                }),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (selected == q['answerIndex']) correct = true;
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"),
                ),
              ],
            );
          });
        },
      );
      if (!correct) allCorrect = false;
    }
  }
  return allCorrect;
}
