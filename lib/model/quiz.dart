class Quiz {
  final String? id;
  final String? category;
  final String? type;
  final String? difficulty;
  final String? question;
  final String? correctAnswer;
  final List<String> incorrectAnswers;

  Quiz({
    required this.id,
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id']?? '0',
      category: json['category']?? 'category_default',
      type: json['type']?? 'type_default',
      difficulty: json['difficulty']?? 'diff_default',
      question: json['question']?? 'question_default',
      correctAnswer: json['correct_answer']?? 'answer_default',
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }
}
