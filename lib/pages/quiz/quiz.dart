import 'package:flutter/material.dart';
import 'package:quiz_backoffice/constants/controllers.dart';
import 'package:quiz_backoffice/helpers/reponsiveness.dart';
import 'package:quiz_backoffice/pages/quiz/widgets/quiz_table.dart';
import 'package:quiz_backoffice/pages/quiz/widgets/quiz_table_fancy.dart';
import 'package:quiz_backoffice/widgets/custom_text.dart';
import 'package:quiz_backoffice/api/quizapi.dart';
import 'package:quiz_backoffice/model/quiz.dart';
import 'package:get/get.dart';

class QuizDetailPage extends StatelessWidget {
  const QuizDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quiz>>(
      future: fetchQuizzes(), // Use your fetchQuizzes function from quizapi.dart
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            children: [
              Obx(() => Row(
                children: [
                  const QuizTableFancy(),
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
