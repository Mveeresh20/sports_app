import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../models/quiz_question.dart';

class QuizService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Initialize quiz data
  Future<void> initializeQuizData() async {
    try {
      final Map<String, dynamic> quizData = {
        "quiz_questions": {
          "easy": {
            "q1": {
              "question": "Who is known as the 'God of Cricket'?",
              "options": [
                "Virat Kohli",
                "Sachin Tendulkar",
                "MS Dhoni",
                "Kapil Dev",
              ],
              "answer": "Sachin Tendulkar",
            },
            // Add more easy questions...
          },
          "medium": {
            "q1": {
              "question": "Which country won the first ICC Cricket World Cup?",
              "options": ["India", "Australia", "West Indies", "England"],
              "answer": "West Indies",
            },
            // Add more medium questions...
          },
          "hard": {
            "q1": {
              "question":
                  "Who has the highest individual score in a single ODI match?",
              "options": [
                "Rohit Sharma",
                "Martin Guptill",
                "Virender Sehwag",
                "Chris Gayle",
              ],
              "answer": "Rohit Sharma",
            },
            // Add more hard questions...
          },
        },
      };

      await _database.set(quizData);
    } catch (e) {
      throw Exception('Failed to initialize quiz data: $e');
    }
  }

  // Upload quiz questions from JSON string
  Future<void> uploadQuizQuestions(String jsonData) async {
    try {
      final Map<String, dynamic> data = json.decode(jsonData);

      // Structure the data properly
      final Map<String, dynamic> formattedData = {
        "quiz_questions": {"easy": {}, "medium": {}, "hard": {}},
      };

      // Format each difficulty level
      ['easy', 'medium', 'hard'].forEach((difficulty) {
        if (data[difficulty] != null) {
          final questions = data[difficulty] as List;
          questions.asMap().forEach((index, question) {
            formattedData["quiz_questions"][difficulty]["q${index + 1}"] =
                question;
          });
        }
      });

      await _database.set(formattedData);
    } catch (e) {
      throw Exception('Failed to upload quiz questions: $e');
    }
  }

  // Fetch questions by difficulty
  Future<List<QuizQuestion>> getQuestionsByDifficulty(String difficulty) async {
    try {
      final snapshot =
          await _database.child('quiz_questions').child(difficulty).get();

      if (!snapshot.exists || snapshot.value == null) {
        print('No data found at path: quiz_questions/$difficulty');
        throw Exception('No questions found for difficulty: $difficulty');
      }

      final data = snapshot.value as Map<dynamic, dynamic>;
      final List<QuizQuestion> questions = [];

      data.forEach((key, value) {
        if (value is Map<dynamic, dynamic>) {
          final questionMap = Map<String, dynamic>.from(value);
          try {
            questions.add(QuizQuestion.fromMap(questionMap));
          } catch (e) {
            print('Error parsing question: $e');
            print('Question data: $questionMap');
          }
        }
      });

      if (questions.isEmpty) {
        throw Exception('No valid questions found for difficulty: $difficulty');
      }

      // Shuffle questions and return only 10
      questions.shuffle();
      return questions.take(10).toList();
    } catch (e) {
      print('Error fetching questions: $e');
      throw Exception('Failed to fetch questions: $e');
    }
  }
}
