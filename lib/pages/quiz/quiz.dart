import 'package:flutter/material.dart';
import 'package:quiz_backoffice/helpers/reponsiveness.dart';
import 'package:quiz_backoffice/constants/controllers.dart';
import 'package:quiz_backoffice/pages/quiz/widgets/quiz_table.dart';
import 'package:quiz_backoffice/widgets/custom_text.dart';
import 'package:quiz_backoffice/api/quizapi.dart'; // Import your QuizApi class
import 'package:quiz_backoffice/model/quiz.dart';
import 'package:get/get.dart';

// ... (existing imports)

class QuizDetailPage extends StatelessWidget {
  final QuizApi quizApi = QuizApi();

  QuizDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                child: CustomText(
                  text: menuController.activeItem.value,
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Quiz>>(
            future: quizApi.fetchQuizzes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView(
                  children: [
                    QuizTable(quizzes: snapshot.data ?? []),
                    // Add more widgets or components as needed
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
