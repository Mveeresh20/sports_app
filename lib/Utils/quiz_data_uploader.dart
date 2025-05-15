import '../services/quiz_service.dart';

class QuizDataUploader {
  static const String quizData = '''
{
  "easy": [
    {
      "question": "Who is known as the 'God of Cricket'?",
      "options": ["Virat Kohli", "Sachin Tendulkar", "MS Dhoni", "Kapil Dev"],
      "answer": "Sachin Tendulkar"
    },
    {
      "question": "How many players are on a cricket team?",
      "options": ["10", "11", "12", "9"],
      "answer": "11"
    },
    {
      "question": "Which country hosts the IPL?",
      "options": ["England", "India", "Australia", "South Africa"],
      "answer": "India"
    },
    {
      "question": "What is the shape of a cricket ball?",
      "options": ["Square", "Round", "Oval", "Flat"],
      "answer": "Round"
    },
    {
      "question": "Which color is used for the ball in Test matches?",
      "options": ["White", "Red", "Pink", "Yellow"],
      "answer": "Red"
    },
    {
      "question": "What is the maximum number of overs in a T20 match per team?",
      "options": ["10", "15", "20", "25"],
      "answer": "20"
    },
    {
      "question": "Who is MS Dhoni?",
      "options": ["Bowler", "Wicketkeeper-batsman", "Umpire", "Coach"],
      "answer": "Wicketkeeper-batsman"
    },
    {
      "question": "Which of these is a cricket format?",
      "options": ["T25", "T40", "T20", "T60"],
      "answer": "T20"
    },
    {
      "question": "What do batsmen wear on their legs for protection?",
      "options": ["Shoes", "Pads", "Helmets", "Caps"],
      "answer": "Pads"
    },
    {
      "question": "Which country does Virat Kohli represent?",
      "options": ["India", "Pakistan", "England", "Sri Lanka"],
      "answer": "India"
    }
  ],
  "medium": [
    {
      "question": "Which country won the first ICC Cricket World Cup?",
      "options": ["India", "Australia", "West Indies", "England"],
      "answer": "West Indies"
    },
    {
      "question": "Who is the first batsman to score a double century in ODI?",
      "options": ["Virender Sehwag", "Rohit Sharma", "Chris Gayle", "Sachin Tendulkar"],
      "answer": "Sachin Tendulkar"
    },
    {
      "question": "Who won the 2011 ICC Cricket World Cup?",
      "options": ["Sri Lanka", "India", "Australia", "South Africa"],
      "answer": "India"
    },
    {
      "question": "Which cricketer is nicknamed 'The Wall'?",
      "options": ["Rahul Dravid", "Sourav Ganguly", "Yuvraj Singh", "MS Dhoni"],
      "answer": "Rahul Dravid"
    },
    {
      "question": "Who was India's captain during the 2007 T20 World Cup?",
      "options": ["MS Dhoni", "Virat Kohli", "Rahul Dravid", "Anil Kumble"],
      "answer": "MS Dhoni"
    },
    {
      "question": "Which cricketer is known for hitting six sixes in an over?",
      "options": ["Chris Gayle", "Yuvraj Singh", "AB de Villiers", "David Warner"],
      "answer": "Yuvraj Singh"
    },
    {
      "question": "Which Indian bowler took a hat-trick in a World Cup?",
      "options": ["Zaheer Khan", "Harbhajan Singh", "Mohammad Shami", "Chetan Sharma"],
      "answer": "Chetan Sharma"
    },
    {
      "question": "Which Indian batsman was known for his helicopter shot?",
      "options": ["Virat Kohli", "MS Dhoni", "Suresh Raina", "KL Rahul"],
      "answer": "MS Dhoni"
    },
    {
      "question": "Who won the Orange Cap in IPL 2021?",
      "options": ["KL Rahul", "Shikhar Dhawan", "Ruturaj Gaikwad", "Virat Kohli"],
      "answer": "Ruturaj Gaikwad"
    },
    {
      "question": "Which team won IPL 2023?",
      "options": ["CSK", "MI", "GT", "RCB"],
      "answer": "CSK"
    }
  ],
  "hard": [
    {
      "question": "Who has the highest individual score in a single ODI match?",
      "options": ["Rohit Sharma", "Martin Guptill", "Virender Sehwag", "Chris Gayle"],
      "answer": "Rohit Sharma"
    },
    {
      "question": "Who bowled the fastest delivery ever recorded in cricket?",
      "options": ["Shoaib Akhtar", "Brett Lee", "Shaun Tait", "Mitchell Starc"],
      "answer": "Shoaib Akhtar"
    },
    {
      "question": "Which player has the most wickets in Test cricket?",
      "options": ["Muttiah Muralitharan", "Shane Warne", "Anil Kumble", "James Anderson"],
      "answer": "Muttiah Muralitharan"
    },
    {
      "question": "Who scored the fastest century in ODIs?",
      "options": ["AB de Villiers", "Corey Anderson", "Virat Kohli", "Shahid Afridi"],
      "answer": "AB de Villiers"
    },
    {
      "question": "Which Indian player has taken all 10 wickets in a Test innings?",
      "options": ["Anil Kumble", "Jasprit Bumrah", "Ishant Sharma", "Kapil Dev"],
      "answer": "Anil Kumble"
    },
    {
      "question": "Which country has never won a Cricket World Cup?",
      "options": ["England", "Pakistan", "New Zealand", "India"],
      "answer": "New Zealand"
    },
    {
      "question": "Who is the only player to have scored 100 international centuries?",
      "options": ["Ricky Ponting", "Virat Kohli", "Sachin Tendulkar", "Brian Lara"],
      "answer": "Sachin Tendulkar"
    },
    {
      "question": "What is the length of a cricket pitch in meters?",
      "options": ["20.12", "21.34", "22", "18.5"],
      "answer": "20.12"
    },
    {
      "question": "Who captained India in its first ever T20 match?",
      "options": ["Virender Sehwag", "Rahul Dravid", "MS Dhoni", "Yuvraj Singh"],
      "answer": "Virender Sehwag"
    },
    {
      "question": "Which batsman has hit the most sixes in international cricket?",
      "options": ["Chris Gayle", "Rohit Sharma", "Shahid Afridi", "MS Dhoni"],
      "answer": "Rohit Sharma"
    }
  ]
}
''';

  static Future<void> uploadQuizData() async {
    try {
      final quizService = QuizService();
      await quizService.uploadQuizQuestions(quizData);
      print('Quiz data uploaded successfully!');
    } catch (e) {
      print('Failed to upload quiz data: $e');
    }
  }
}
