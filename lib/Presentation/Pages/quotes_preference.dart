import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Pages/home_screen.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Utils/Constants/text.dart';

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
    // Get screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),

                          // Skip button
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "Skip",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xFF9B9EA1),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Color(0xFF9B9EA1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Title
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 21,
                        right: 21,
                        top: 8,
                      ),
                      child: Text(
                        "Select your quotes preferences",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: screenSize.width > 360 ? 32 : 28,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: Text(
                        LoremIpsum.p4,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: const Color(0xFF7B8A99),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Topics wrap
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 12,
                        children:
                            _topics.map((topic) {
                              final isSelected = _selectedTopics.contains(
                                topic,
                              );

                              return GestureDetector(
                                onTap: () {
                                  _toggleTopic(topic);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color:
                                        isSelected
                                            ? const Color(0xFFFFFFFF)
                                            : const Color(0xFF1E2730),
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? const Color(0xFF1E2730)
                                              : const Color(0xFF32363A),
                                      width: isSelected ? 2 : 1,
                                    ),
                                    boxShadow: [
                                      if (isSelected)
                                        BoxShadow(
                                          color: const Color(
                                            0xFFFC5000,
                                          ).withAlpha(65),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                          spreadRadius: 0,
                                        )
                                      else ...[
                                        BoxShadow(
                                          color: Colors.black.withAlpha(64),
                                          offset: const Offset(0, 4),
                                          blurRadius: 7.5,
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withAlpha(64),
                                          offset: const Offset(0, 2),
                                          blurRadius: 11.1,
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: const Color(
                                            0xFF516A82,
                                          ).withAlpha(51),
                                          offset: const Offset(0, 4),
                                          blurRadius: 10.7,
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: const Color(
                                            0xFF6E87A0,
                                          ).withAlpha(77),
                                          offset: const Offset(0, 1),
                                          blurRadius: 0,
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    topic,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color:
                                          isSelected
                                              ? Colors.black
                                              : Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),

                  
                    SizedBox(height: screenSize.height * 0.1),
                  ],
                ),
              ),
            ),

            // Fixed bottom button that's always visible
            Padding(
              padding: const EdgeInsets.all(20),
              child: SigninPageButtons(
                buttonText: "Select (${_selectedTopics.length})",
                onpressed: () {
                  if (_selectedTopics.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select at least one topic'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Navigate to next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
