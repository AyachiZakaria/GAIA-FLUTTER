import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_web_dashboard/model/quiz.dart';

// Fetch quiz data
Future<List<Quiz>> fetchQuizzes() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/quiz'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((quiz) => Quiz.fromJson(quiz)).toList();
  } else {
    throw Exception('Failed to load quizzes');
  }
}

// Delete a quiz by ID
Future<void> deleteQuiz(String id) async {
  final response = await http.delete(Uri.parse('http://127.0.0.1:3000/api/quiz/$id'));

  if (response.statusCode != 200) {
    throw Exception('Failed to delete quiz');
  }
}
