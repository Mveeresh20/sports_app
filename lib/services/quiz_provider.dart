import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import 'quiz_service.dart';

class QuizProvider extends ChangeNotifier {
  final QuizService _quizService = QuizService();
  List<QuizQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = false;
  Map<int, String> _userAnswers = {};

  // Getters
  List<QuizQuestion> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isLoading => _isLoading;
  bool get isQuizComplete => _currentQuestionIndex >= _questions.length;
  QuizQuestion? get currentQuestion =>
      _questions.isNotEmpty && _currentQuestionIndex < _questions.length
          ? _questions[_currentQuestionIndex]
          : null;
  Map<int, String> get userAnswers => _userAnswers;

  
  Future<void> loadQuestions(String difficulty) async {
    try {
      _isLoading = true;
      notifyListeners();

      _questions = await _quizService.getQuestionsByDifficulty(difficulty);
      _currentQuestionIndex = 0;
      _score = 0;
      _userAnswers.clear();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Answer current question
  void answerQuestion(String answer) {
    if (isQuizComplete) return;

    _userAnswers[_currentQuestionIndex] = answer;
    if (answer == _questions[_currentQuestionIndex].answer) {
      _score++;
    }

    _currentQuestionIndex++;
    notifyListeners();
  }

  // Reset quiz
  void resetQuiz() {
    _questions = [];
    _currentQuestionIndex = 0;
    _score = 0;
    _userAnswers.clear();
    notifyListeners();
  }

  // Get results summary
  Map<String, dynamic> getQuizSummary() {
    return {
      'totalQuestions': _questions.length,
      'correctAnswers': _score,
      'incorrectAnswers': _questions.length - _score,
      'percentage': (_score / _questions.length * 100).toStringAsFixed(1),
      'answers': _userAnswers,
    };
  }
}
