import 'package:flutter/material.dart';

class QuizProgressButton extends StatefulWidget {
  const QuizProgressButton({super.key});

  @override
  State<QuizProgressButton> createState() => _QuizProgressButtonState();
}

class _QuizProgressButtonState extends State<QuizProgressButton> {
  String selectedLevel = 'Basic';

  final List<String> levels = ['Basic', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(59),
          color: Color(0xFF1E2730)
        ),
       
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: levels.map((level) {
              bool isSelected = selectedLevel == level;
                
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedLevel = level;
                  });
                },
                child: Container(
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(59),
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [Color(0xFFF23943), Color(0xFFC1232C)],
                          )
                        : null,
                    
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 33,vertical: 7),
                    child: Text(
                      level,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ); 
  }
}