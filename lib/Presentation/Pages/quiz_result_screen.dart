import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/quiz_provider.dart';
import 'questions_level_screen.dart';
import 'quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({Key? key}) : super(key: key);

  Widget _buildResultRow(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1E2730),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF34464F)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF7B8A99),
              fontFamily: "Plus Jakarta Sans",
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isHighlighted ? Color(0xFFF23943) : Colors.white,
              fontFamily: "Plus Jakarta Sans",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final summary = quizProvider.getQuizSummary();
    final score = double.parse(summary['percentage']);
    final isPassed = score >= 40;

    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () {
                      quizProvider.resetQuiz();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionsLevelScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  Text(
                    'Quiz Result',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: "Plus Jakarta Sans",
                    ),
                  ),
                  SizedBox(width: 40), // Balance the back button
                ],
              ),
            ),

            SizedBox(height: 16),

            // Divider
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF27313B), width: 1),
                ),
              ),
            ),

            SizedBox(height: 32),

            // Result Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                isPassed ? 'Congratulations! 🎉' : 'Keep Practicing! 💪',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "Plus Jakarta Sans",
                ),
              ),
            ),

            SizedBox(height: 16),

            // Score Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                isPassed
                    ? 'You\'ve passed the quiz!'
                    : 'You can do better next time.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7B8A99),
                  fontFamily: "Plus Jakarta Sans",
                ),
              ),
            ),

            SizedBox(height: 32),

            // Results Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildResultRow(
                    'Total Questions',
                    '${summary['totalQuestions']}',
                  ),
                  SizedBox(height: 12),
                  _buildResultRow(
                    'Correct Answers',
                    '${summary['correctAnswers']}',
                  ),
                  SizedBox(height: 12),
                  _buildResultRow(
                    'Incorrect Answers',
                    '${summary['incorrectAnswers']}',
                  ),
                  SizedBox(height: 12),
                  _buildResultRow(
                    'Your Score',
                    '${summary['percentage']}%',
                    isHighlighted: true,
                  ),
                ],
              ),
            ),

            Spacer(),

            // Try Another Quiz Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Color(0xFF9F0FF7), Color(0xFFF23943)],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    quizProvider.resetQuiz();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionsLevelScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Try Another Quiz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: "Plus Jakarta Sans",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
