import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 3;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

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
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF101922),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 852,
                    child: Image.network(Images.img1, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 447,
                    left: 20,
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          color: Color(0xFFFFFFFF),
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(text: "Get Inspired\nto "),
                          TextSpan(
                            text: "Win!",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                              color: Color(0xFFC1232C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    top: 620,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 20,
                      child: Text(
                        LoremIpsum.p1,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xFFA5B1BD),
                          height: 1.43,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: UI.borderRadius32,
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Skip",
                                style: TextStyle(color: Color(0xFF727272)),
                              ),
                            ),
                            SizedBox(width: 55),
                            _buildPageIndicator(),
                            SizedBox(width: 55),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF23943),
                                shape: RoundedRectangleBorder(
                                  borderRadius: UI.borderRadius32,
                                ),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
