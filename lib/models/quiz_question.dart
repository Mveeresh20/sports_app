class QuizQuestion {
  final String question;
  final List<String> options;
  final String answer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      question: map['question'] as String,
      options: List<String>.from(map['options'] as List),
      answer: map['answer'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'question': question, 'options': options, 'answer': answer};
  }
}
