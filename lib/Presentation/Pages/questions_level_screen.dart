import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Widgets/levels_button.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';

class QuestionsLevelScreen extends StatefulWidget {
  const QuestionsLevelScreen({super.key});

  @override
  State<QuestionsLevelScreen> createState() => _QuestionsLevelScreenState();
}

class _QuestionsLevelScreenState extends State<QuestionsLevelScreen> {
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
                  ), // Only bottom border with 1px width
                ),
              ),
            ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: LevelsButton(),
          ),
          Spacer(),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13).copyWith(bottom:52 ),
            child: SigninPageButtons(buttonText: "Next", onpressed: (){}),
          )
        ],
      ),
    );
  }
}
