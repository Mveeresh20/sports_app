import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Pages/add_quote_screen.dart';
import 'package:sports_app/Presentation/Pages/questions_level_screen.dart';
import 'package:sports_app/Presentation/Pages/quotes_screen.dart';
import 'package:sports_app/Presentation/Pages/select_sports.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Presentation/Widgets/start_quiz_button.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';

class QuotesScreen2 extends StatefulWidget {
  const QuotesScreen2({super.key});

  @override
  State<QuotesScreen2> createState() => _QuotesScreen2State();
}

class _QuotesScreen2State extends State<QuotesScreen2> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('Bottom navigation item tapped: $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),

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
                  const SizedBox(width: 117),
                  const Text(
                    "Quiz",
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
            SizedBox(height: 8),
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
            SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF9F0FF7), Color(0xFFF03F3F)],
                  ).createShader(bounds);
                },
                child: const Text(
                  LoremIpsum.p12,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                LoremIpsum.p13,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF7B8A99),
                ),
              ),
            ),
            SizedBox(height: 239),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: Text(
                  "Are You Ready to Take the Challenge?",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 29),

            StartQuizButton(
              buttonText: "Start the Quiz",
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectSports()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1E2730),

        shape: CircleBorder(),
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuoteScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.red),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: PhysicalModel(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),

          child: BottomAppBar(
            color: Color(0xFF101822),
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  // Wrap with a GestureDetector
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuotesScreen()),
                    );
                  }, // Move onTap here
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        // Add Icon here
                        Icons.format_quote_sharp,
                        color:
                            _selectedIndex == 0
                                ? Colors.grey
                                : Colors.redAccent,
                      ),
                      Text(
                        "Quotes",
                        style: TextStyle(color: Color(0xFF7B8A99)),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 48.0),
                GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x99E9353F), Color(0x00EA3640)],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(Images.img12, height: 28, width: 28),
                        SizedBox(height: 3),

                        Text(
                          "Quiz",
                          style: TextStyle(
                            color:
                                _selectedIndex == 1
                                    ? Colors.grey
                                    : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
