import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/quiz_provider.dart';
import '../Widgets/levels_button.dart';
import 'quiz_screen.dart';

class QuestionsLevelScreen extends StatefulWidget {
  const QuestionsLevelScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsLevelScreen> createState() => _QuestionsLevelScreenState();
}

class _QuestionsLevelScreenState extends State<QuestionsLevelScreen> {
  String? selectedLevel;
  bool isLoading = false;

  void onLevelSelected(String level) {
    setState(() {
      selectedLevel = level;
    });
  }

  void _startQuiz(BuildContext context) async {
    if (selectedLevel == null) return;
    setState(() => isLoading = true);
    try {
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      await quizProvider.loadQuestions(selectedLevel!.toLowerCase());
      setState(() => isLoading = false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizScreen(difficulty: '')),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load questions: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Levels",
                        style: TextStyle(
                          fontFamily: "Plus Jakarta Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            SizedBox(height: 16),
            // LevelsButton UI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LevelsButton(onLevelSelected: onLevelSelected),
            ),
            const Spacer(),
            // Next Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed:
                      (selectedLevel == null || isLoading)
                          ? null
                          : () => _startQuiz(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF23943),
                    disabledBackgroundColor: const Color(0xFF7B8A99),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child:
                      isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
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
          ],
        ),
      ),
    );
  }
}
