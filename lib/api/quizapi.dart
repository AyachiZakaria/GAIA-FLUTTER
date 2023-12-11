import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_backoffice/model/quiz.dart';

class QuizApi {
  static const String apiUrl = 'http://localhost:3000/api/quiz'; // Replace with your API endpoint

  Future<List<Quiz>> fetchQuizzes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> quizJsonList = jsonDecode(response.body);
      return quizJsonList.map((quizJson) => Quiz.fromJson(quizJson)).toList();
    } else {
      throw Exception('Failed to load quizzes');
    }
  }
}
