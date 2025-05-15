


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/quiz_provider.dart';
import 'score_pass.dart';
import 'score_failed.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required String difficulty});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _selectedAnswerIndex = -1;
  int _timeLeft = 235;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        // Optionally auto-skip or auto-next
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes}min ${remainingSeconds}s';
  }

  void _handleAnswerSelection(int index, QuizProvider provider) {
    setState(() {
      _selectedAnswerIndex = index;
    });
    // Optionally: provider.answerQuestion(provider.currentQuestion.options[index]);
  }

  void _handleNext(QuizProvider provider) {
    if (_selectedAnswerIndex != -1 && provider.currentQuestion != null) {
      provider.answerQuestion(
        provider.currentQuestion!.options[_selectedAnswerIndex],
      );
      setState(() {
        _selectedAnswerIndex = -1;
        _timeLeft = 235;
      });
      if (provider.isQuizComplete) {
        final summary = provider.getQuizSummary();
        final double percentage =
            double.tryParse(summary['percentage'].toString()) ?? 0;
        final int correct = summary['correctAnswers'] ?? 0;
        final int incorrect = summary['incorrectAnswers'] ?? 0;
        final int skipped =
            (summary['totalQuestions'] ?? 0) - correct - incorrect;
        if (percentage > 30) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ScorePass(
                    correct: correct,
                    incorrect: incorrect,
                    skipped: skipped,
                    percentage: percentage,
                  ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ScoreFailed(
                    correct: correct,
                    incorrect: incorrect,
                    skipped: skipped,
                    score: percentage,
                  ),
            ),
          );
        }
      }
    }
  }

  void _handleSkip(QuizProvider provider) {
    provider.answerQuestion("");
    setState(() {
      _selectedAnswerIndex = -1;
      _timeLeft = 235;
    });
    if (provider.isQuizComplete) {
      final summary = provider.getQuizSummary();
      final double percentage =
          double.tryParse(summary['percentage'].toString()) ?? 0;
      final int correct = summary['correctAnswers'] ?? 0;
      final int incorrect = summary['incorrectAnswers'] ?? 0;
      final int skipped =
          (summary['totalQuestions'] ?? 0) - correct - incorrect;
      if (percentage > 30) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ScorePass(
                  correct: correct,
                  incorrect: incorrect,
                  skipped: skipped,
                  percentage: percentage,
                ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ScoreFailed(
                  correct: correct,
                  incorrect: incorrect,
                  skipped: skipped,
                  score: percentage,
                ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context);
    final currentQuestion = provider.currentQuestion;
    final currentIndex = provider.currentQuestionIndex + 1;
    final totalQuestions = provider.questions.length;

    if (currentQuestion == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF101922),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 117),
                  const Text(
                    "Levels",
                    style: TextStyle(
                      fontFamily: "Plus Jakarta Sans",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF27313B), width: 1),
                ),
              ),
            ),
            SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$currentIndex/$totalQuestions',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.red),
                      const SizedBox(width: 5),
                      Text(
                        _formatTime(_timeLeft),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 13),
            Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: Row(
                    children: List.generate(
                      totalQuestions,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                colors:
                                    index < currentIndex
                                        ? [Color(0xFFFC5000), Color(0xFF9F0FF7)]
                                        : [
                                          Color(0xFFD9D9D9),
                                          Color(0xFFD9D9D9),
                                        ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Q$currentIndex. ${currentQuestion.question}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Answer Options
            ...currentQuestion.options.asMap().entries.map((entry) {
              int index = entry.key;
              String answer = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20,
                ),
                child: GestureDetector(
                  onTap: () => _handleAnswerSelection(index, provider),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            _selectedAnswerIndex == index
                                ? Colors.red
                                : Color(0xFF454545),
                      ),
                      color:
                          _selectedAnswerIndex == index
                              ? Color(0xFFFD3741)
                              : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color:
                                    _selectedAnswerIndex == index
                                        ? Color(0xFFC1232C)
                                        : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child:
                                _selectedAnswerIndex == index
                                    ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFF23943),
                                              Color(0xFFC1232C),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              answer,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
            // Buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Next
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          _selectedAnswerIndex == -1
                              ? null
                              : () => _handleNext(provider),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF23943),
                        disabledBackgroundColor: const Color(0xFF7B8A99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontFamily: "Plus Jakarta Sans",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Skip
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _handleSkip(provider),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF1E2730)),
                        backgroundColor: Color(0xFF1E2730),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontFamily: "Plus Jakarta Sans",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
