import 'package:flutter/material.dart';
import 'screens/chapter_selection.dart';
import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.initialize();
  runApp(AStudyApp());
}

class AStudyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bioQbank',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChapterSelectionScreen(),
    );
  }
}
