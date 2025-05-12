import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionViewerScreen extends StatefulWidget {
  final List<Question> questions;
  QuestionViewerScreen({required this.questions});

  @override
  _QuestionViewerScreenState createState() => _QuestionViewerScreenState();
}

class _QuestionViewerScreenState extends State<QuestionViewerScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Q${_index + 1} of ${widget.questions.length}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(q.text, style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            ...List.generate(q.options.length, (i) {
              return ListTile(
                title: Text(q.options[i]),
                leading: Radio<int>(
                  value: i,
                  groupValue: null,
                  onChanged: (_) {},
                ),
              );
            }),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_index < widget.questions.length - 1) {
                  setState(() => _index++);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(_index < widget.questions.length - 1 ? 'Next' : 'Done'),
            ),
          ],
        ),
      ),
    );
  }
}
