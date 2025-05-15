import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Pages/add_quote_screen.dart';
import 'package:sports_app/Presentation/Pages/score_pass.dart';
import 'dart:async';

import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Presentation/Widgets/skip_butoon.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 6;
  final int _totalQuestions = 10;
  String _questionText = "Q1. How many players can play in one cricket match?";
  List<String> _answers = ["12", "32", "9", "11", "9"];
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
    _timer?.cancel(); // Stop previous timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        // Timeout logic here
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes}min ${remainingSeconds}s';
  }

  void _handleAnswerSelection(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
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
                  bottom: BorderSide(
                    color: Color(0xFF27313B),
                    width: 1,
                  ), 
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
                    '$_currentQuestion/$_totalQuestions',
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
                      _totalQuestions,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                colors:
                                    index < _currentQuestion
                                        ? [
                                          Color(0xFFFC5000),
                                          Color(0xFF9F0FF7),
                                        ] 
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

            // Fill Info
            const SizedBox(height: 24),

            // Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _questionText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Answer Options
            ..._answers.asMap().entries.map((entry) {
              int index = entry.key;
              String answer = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20,
                ),
                child: GestureDetector(
                  onTap: () => _handleAnswerSelection(index),
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
                              ? Color(
                                0xFFFD3741,
                              ) 
                              : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _handleAnswerSelection(index),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient:
                                    _selectedAnswerIndex == index
                                        ? const LinearGradient(
                                          colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0xFFFFFFFF),
                                          ],
                                        )
                                        : null,
                                color:
                                    _selectedAnswerIndex == index
                                        ? Colors.white
                                        : Colors.white,
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
                SigninPageButtons(
                  buttonText: "Next",
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ScorePass(
                              correct: 7, 
                              incorrect: 2, 
                              skipped: 1, 
                              percentage: 80.0, 
                            ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),

                SkipButoon(buttonText: "Skip", onpressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
