import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  static const _baseUrl = 'https://api.astudy.app';

  static Future<void> initialize() async {
    // Any init: e.g. DB, headers
  }

  static Future<List<String>> fetchChapters(int cls) async {
    final res = await http.get(Uri.parse('$_baseUrl/chapters?class=$cls'));
    final list = jsonDecode(res.body) as List;
    return list.map((e) => e.toString()).toList();
  }

  static Future<List<Question>> generateQuestions({
    required int cls,
    required String chapter,
    required int count,
  }) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/generate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'class': cls,
        'chapter': chapter,
        'num_questions': count,
      }),
    );
    final data = jsonDecode(res.body) as List;
    return data.map((e) => Question.fromJson(e)).toList();
  }
}
