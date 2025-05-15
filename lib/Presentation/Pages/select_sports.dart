import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Pages/questions_level_screen.dart';
import 'package:sports_app/Presentation/Widgets/select_sports_button.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/models/quiz_item.dart';

class SelectSports extends StatefulWidget {
  const SelectSports({super.key});

  @override
  State<SelectSports> createState() => _SelectSportsState();
}

class _SelectSportsState extends State<SelectSports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
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

                  Expanded(
                    child: Center(
                      child: Text(
                        "Select Sports",
                        style: TextStyle(
                          fontFamily: "Plus Jakarta Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
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

            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 24),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: quizList.length,
              itemBuilder: (context, index) {
                final quiz = quizList[index];
                final isEven = index % 2 == 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1E29),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isEven ? Colors.purpleAccent : Colors.blueAccent,
                        width: 1.5,
                      ),
                    ),

                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                isEven
                                    ? [
                                      // Text content first
                                      _buildTextColumn(quiz),
                                      SizedBox(width: 90),
                                    ]
                                    : [
                                      // Image first
                                      SizedBox(width: 90),
                                      _buildTextColumn(quiz),
                                    ],
                          ),
                        ),
                        Positioned(
                          right: isEven ? 0 : null,
                          left: isEven ? null : 0,
                          top: -30,
                          bottom: 0,
                          child: _buildImage(quiz.imageUrl),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
              ).copyWith(bottom: 80),
              child: Center(
                child: Text(
                  "(You need to score at least 40% to pass the quiz)",
                  style: TextStyle(
                    color: Color(0xFF7B8A99),
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextColumn(QuizItem quiz) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quiz.title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            quiz.description,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
              fontSize: 12,
              color: Color(0xFF7B8A99),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionsLevelScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            child: Text(
              "Start now",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return Image.network(url, fit: BoxFit.contain);
  }
}
