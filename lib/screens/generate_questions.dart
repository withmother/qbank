import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/question.dart';
import 'question_viewer.dart';

class GenerateQuestionsScreen extends StatefulWidget {
  final int cls;
  final String chapterName;
  GenerateQuestionsScreen({required this.cls, required this.chapterName});

  @override
  _GenerateQuestionsScreenState createState() =>
      _GenerateQuestionsScreenState();
}

class _GenerateQuestionsScreenState extends State<GenerateQuestionsScreen> {
  int _numQuestions = 1000;
  bool _loading = false;

  void _generate() async {
    setState(() => _loading = true);
    final questions = await ApiService.generateQuestions(
      cls: widget.cls,
      chapter: widget.chapterName,
      count: _numQuestions,
    );
    setState(() => _loading = false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionViewerScreen(questions: questions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chapterName)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Number of Questions: $_numQuestions'),
            Slider(
              value: _numQuestions.toDouble(),
              min: 100,
              max: 2000,
              divisions: 19,
              onChanged: (v) => setState(() => _numQuestions = v.toInt()),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _generate,
              child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
