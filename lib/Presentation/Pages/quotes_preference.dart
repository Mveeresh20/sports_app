import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class QuotesPreference extends StatefulWidget {
  const QuotesPreference({super.key});

  @override
  State<QuotesPreference> createState() => _QuotesPreferenceState();
}

class _QuotesPreferenceState extends State<QuotesPreference> {
  final List<String> _topics = [
    'Mindset',
    'Technique & Strategy',
    'Stamina',
    'Teamwork',
    'Patience',
    'Motivation & Inspiration',
    'Willpower',
    'Discipline',
  ];

  
  final Set<String> _selectedTopics = {};

  
  void _toggleTopic(String topic) {
    setState(() {
      if (_selectedTopics.contains(topic)) {
        _selectedTopics.remove(topic);
      } else {
        _selectedTopics.add(topic);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
              ).copyWith(top: 65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "skip",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xFF9B9EA1),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xFF9B9EA1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 22),
        
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: Text("Select your quotes Prefernces", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 32, color: Colors.white,)),
            ),
            SizedBox(height: 28),
        
            Container(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Text(
                    LoremIpsum.p4,
                    style: GoogleFonts.poppins(
                      
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xFF7B8A99),
                    ),
                  ),
                ),
            ),
            SizedBox(height: 47),
           Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 4,
            runSpacing: 10,
            children: _topics.map((topic) {
        final isSelected = _selectedTopics.contains(topic);
        
        if (isSelected) {
          // Container for SELECTED topics
          return GestureDetector(
            onTap: () {
              _toggleTopic(topic);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Color(0xFFFFFFFF), // Styling for selected
                border: Border.all(
                  color: Color(0xFF1E2730), // Border for selected
                  width: 2,
                ),
                boxShadow: [
                   BoxShadow(
                    color: Color(0xFFFC5000).withAlpha(65),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                topic,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black, // Text color for selected
                ),
              ),
            ),
          );
        } else {
        
          return GestureDetector(
            onTap: () {
              _toggleTopic(topic);
            },
            child: Container(
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Color(0xFF1E2730), // Background color for unselected
                border: Border.all(
                  color: Color(0xFF32363A), 
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(64),
                    offset: Offset(0, 4),
                    blurRadius: 7.5,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withAlpha(64),
                    offset: Offset(0, 2),
                    blurRadius: 11.1,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color(0xFF516A82).withAlpha(51),
                    offset: Offset(0, 4),
                    blurRadius: 10.7,
                    spreadRadius: 0,
                    
                  ),
                  BoxShadow(
                    color: Color(0xFF6E87A0).withAlpha(77),
                    offset: Offset(0, 1),
                    blurRadius: 0,
                    spreadRadius: 0,
                    
                  ),
                 
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                topic,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white, // Text color for unselected
                ),
              ),
            ),
          );
        }
            }).toList(),
          ),
        ),
        
        SizedBox(height: 284,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SigninPageButtons(buttonText: "Select", onpressed: (){
            
          }),
        )
        
          ],
        ),
      ),
    );
  }
}
