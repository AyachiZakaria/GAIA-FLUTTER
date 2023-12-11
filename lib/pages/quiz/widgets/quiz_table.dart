import 'package:flutter/material.dart';
import 'package:quiz_backoffice/constants/style.dart';
import 'package:quiz_backoffice/widgets/custom_text.dart';
import 'package:quiz_backoffice/model/quiz.dart';

class QuizTable extends StatefulWidget {
  final List<Quiz> quizzes;

  const QuizTable({Key? key, required this.quizzes}) : super(key: key);

  @override
  _QuizTableState createState() => _QuizTableState();
}

class _QuizTableState extends State<QuizTable> {
  String selectedDifficulty = 'All';

  @override
  Widget build(BuildContext context) {
    // Filter quizzes based on the selected difficulty
    final filteredQuizzes = selectedDifficulty == 'All'
        ? widget.quizzes
        : widget.quizzes.where((quiz) => quiz.difficulty == selectedDifficulty).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [BoxShadow(offset: const Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: "Quiz Data",
                color: lightGrey,
                weight: FontWeight.bold,
                size: 20,
              ),
              SizedBox(width: 20),
              DropdownButton<String>(
                value: selectedDifficulty,
                onChanged: (value) {
                  setState(() {
                    selectedDifficulty = value!;
                  });
                },
                items: ['All', 'easy', 'medium', 'hard'].map<DropdownMenuItem<String>>((difficulty) {
                  return DropdownMenuItem<String>(
                    value: difficulty,
                    child: CustomText(text: difficulty),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: (56 * filteredQuizzes.length) + 40,
            child: DataTable(
              columnSpacing: 12,
              dataRowHeight: 56,
              headingRowHeight: 40,
              horizontalMargin: 12,
              columns: const [
                DataColumn(
                  label: Text("#"),
                ),
                DataColumn(
                  label: Text("Question"),
                ),
                DataColumn(
                  label: Text('Category'),
                ),
                DataColumn(
                  label: Text('Type'),
                ),
                DataColumn(
                  label: Text('Difficulty'),
                ),
                DataColumn(
                  label: Text('Actions'),
                ),
              ],
              rows: filteredQuizzes.asMap().entries.map<DataRow>((entry) {
                final index = entry.key;
                final quiz = entry.value;

                return DataRow(
                  cells: [
                    DataCell(
                      CustomText(
                        text: "${index + 1}",
                        weight: FontWeight.bold,
                      ),
                    ),
                    DataCell(
                      CustomText(
                        text: quiz.question,
                      ),
                    ),
                    DataCell(
                      CustomText(
                        text: quiz.category,
                      ),
                    ),
                    DataCell(
                      CustomText(
                        text: quiz.type,
                      ),
                    ),
                    DataCell(
                      CustomText(
                        text: quiz.difficulty,
                        weight: FontWeight.bold,
                        color: _getColorForDifficulty(quiz.difficulty),
                      ),
                    ),
                    DataCell(
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.visibility),
                                title: CustomText(
                                  text: 'Show Details',
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  _showQuizDetailsDialog(context, quiz);
                                },
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: CustomText(
                                  text: 'Delete',
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  _showDeleteConfirmation(context, quiz);
                                },
                              ),
                            ),
                          ];
                        },
                        icon: Icon(Icons.more_vert),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showQuizDetailsDialog(BuildContext context, Quiz quiz) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "Quiz Details",
                color: Colors.black,
                weight: FontWeight.bold,
                size: 18,
              ),
              SizedBox(height: 16),
              _buildDetailRow("Question:", quiz.question),
              _buildDetailRow("Answer:", quiz.correctAnswer),
              _buildDetailRow("Wrong answer 1:", quiz.incorrectAnswers[0]),
              _buildDetailRow("Wrong answer 2:", quiz.incorrectAnswers[1]),
              _buildDetailRow("Wrong answer 3:", quiz.incorrectAnswers[2]),
              _buildDetailRow("Difficulty:", quiz.difficulty),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CustomText(
                    text: 'Close',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            color: Colors.black,
            weight: FontWeight.bold,
          ),
          SizedBox(width: 8),
          Expanded(
            child: CustomText(
              text: value,
              color: Colors.black54,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }


  //feetus deletus
  void _showDeleteConfirmation(BuildContext context, Quiz quiz) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(text: "Delete Quiz"),
          content: CustomText(text: "Are you sure you want to delete this quiz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: CustomText(
                text: 'Cancel',
                color: Colors.blue,
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteQuiz(context, quiz);
              },
              child: CustomText(
                text: 'Delete',
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteQuiz(BuildContext context, Quiz quiz) {
    // Handle quiz deletion logic here
    // ...
    Navigator.pop(context); // Close the delete confirmation dialog
  }

  Color _getColorForDifficulty(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
