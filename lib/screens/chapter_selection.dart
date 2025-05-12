import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'generate_questions.dart';

class ChapterSelectionScreen extends StatefulWidget {
  @override
  _ChapterSelectionScreenState createState() =>
      _ChapterSelectionScreenState();
}

class _ChapterSelectionScreenState extends State<ChapterSelectionScreen> {
  int _selectedClass = 11;
  List<String> _chapters = [];
  String? _selectedChapter;

  void _loadChapters() async {
    final chapters = await ApiService.fetchChapters(_selectedClass);
    setState(() {
      _chapters = chapters;
      _selectedChapter = chapters.isNotEmpty ? chapters.first : null;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Chapter')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<int>(
              value: _selectedClass,
              items: [11, 12]
                  .map((c) => DropdownMenuItem(
                      value: c, child: Text('Class $c')))
                  .toList(),
              onChanged: (v) {
                setState(() => _selectedClass = v!);
                _loadChapters();
              },
            ),
            SizedBox(height: 16),
            if (_chapters.isEmpty)
              Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _chapters.length,
                  itemBuilder: (ctx, i) {
                    final chap = _chapters[i];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: ListTile(
                        title: Text(chap),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GenerateQuestionsScreen(
                                cls: _selectedClass,
                                chapterName: chap,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
