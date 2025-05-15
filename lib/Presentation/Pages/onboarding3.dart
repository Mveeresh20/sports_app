import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Pages/onboarding2.dart';
import 'package:sports_app/Presentation/Pages/sign_in.dart';
import 'package:sports_app/Presentation/Pages/skip_page.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  State<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3> {
  final int _currentPage = 2; // Hardcoded to third page
  final int _numPages = 3;

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
      body: Stack(
        children: [
          Image.network(Images.img3, fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
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
                  const TextSpan(text: "Stay "),
                  TextSpan(
                    text: "inspired\n",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: const Color(0xFFC1232C),
                    ),
                  ),
                  const TextSpan(text: "and "),
                  TextSpan(
                    text: "challenged\n",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: const Color(0xFFC1232C),
                    ),
                  ),
                  const TextSpan(text: "every day"),
                ],
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
                          builder: (context) => SignIn(),
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
                          builder: (context) => SignIn(),
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




