import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Pages/questions_level_screen.dart';
import 'package:sports_app/Presentation/Pages/quotes_screen2.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Presentation/Widgets/skip_butoon.dart';
import 'package:sports_app/Utils/Constants/images.dart';

class ScoreFailed extends StatefulWidget {
  final int correct;
  final int incorrect;
  final int skipped;
  final double score;
  const ScoreFailed({
    super.key,
    required this.correct,
    required this.incorrect,
    required this.skipped,
    required this.score,
  });

  @override
  State<ScoreFailed> createState() => _ScoreFailedState();
}

class _ScoreFailedState extends State<ScoreFailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ).copyWith(top: 48),
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
                      "Score",
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
                ), // Only bottom border with 1px width
              ),
            ),
          ),
          SizedBox(height: 15),
      
          Center(
            child: Text(
              "Better Luck Next Time",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              "(You need to score at least 40% to pass the quiz)",
              style: TextStyle(
                color: Color(0xFF7B8A99),
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(child: Image.network(Images.img21,height: 220,),),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "correct answer",
                      style: TextStyle(
                        color: Color(0xFF7B8A99),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF1E2730),
                        ),
      
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 12,
                          ),
                          child: Text(
                            "${widget.correct}",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Completion",
                      style: TextStyle(
                        color: Color(0xFF7B8A99),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF1E2730),
                        ),
      
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 12,
                          ),
                          child: Text(
                            "${widget.score.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
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
          SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "skipped",
                      style: TextStyle(
                        color: Color(0xFF7B8A99),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF1E2730),
                        ),
      
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 12,
                          ),
                          child: Text(
                            "${widget.skipped}",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Incorrect answer",
                      style: TextStyle(
                        color: Color(0xFF7B8A99),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF1E2730),
                        ),
      
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 12,
                          ),
                          child: Text(
                            "${widget.incorrect}",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
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
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SigninPageButtons(
              buttonText: "Back to home",
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuotesScreen2()),
                );
              },
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SkipButoon(
              buttonText: "Retake",
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionsLevelScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
