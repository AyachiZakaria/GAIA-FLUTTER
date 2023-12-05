import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/pages/quiz/widgets/quiz_table.dart'; // Import your quiz-related widgets
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:flutter_web_dashboard/api/quizapi.dart';
import 'package:flutter_web_dashboard/model/quiz.dart';
import 'package:get/get.dart';

class QuizDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quiz>>(
      future: fetchQuizzes(), // Use your fetchQuizzes function from quizapi.dart
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            children: [
              Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
              Expanded(
                child: ListView(
                  children: [
                    QuizTable(quizzes: snapshot.data ?? []), // Use a widget that displays your quiz data
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
