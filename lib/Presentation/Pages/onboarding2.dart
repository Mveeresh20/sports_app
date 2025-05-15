import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Pages/onboarding3.dart';
import 'package:sports_app/Presentation/Pages/skip_page.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  final int _numPages = 3;

  // Hardcode current page as 1 since this is Onboarding screen 2
  final int _currentPage = 1;

  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(_indicator(i == _currentPage));
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 20.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFC1232C) : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: 
        
         Stack(
          children: [
            Image.network(Images.img2, fit: BoxFit.cover,height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,),
            Padding(
              padding: const EdgeInsets.only(top: 400,left: 20),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: const Color(0xFFFFFFFF),
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(
                      text: "Challenge",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 40,
                        color: const Color(0xFFC1232C),
                      ),
                    ),
                    const TextSpan(text: "Your\nSports\n"),
                    TextSpan(
                      text: "Knoweledge",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 40,
                        color: const Color(0xFFC1232C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 550,right: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text(
                  LoremIpsum.p2,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: const Color(0xFFA5B1BD),
                    height: 1.43,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17).copyWith(bottom: 38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: UI.borderRadius32,
                        ),
                      ),
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SkipPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Color(0xFF727272)),
                      ),
                    ),
                    const SizedBox(width: 55),
                    _buildPageIndicator(),
                    const SizedBox(width: 55),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF23943),
                        shape: RoundedRectangleBorder(
                          borderRadius: UI.borderRadius32,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Onboarding3(),
                        ),
                      );
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}


