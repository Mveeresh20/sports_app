import 'package:flutter/material.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';

class QuotesScreenProfile extends StatefulWidget {
  const QuotesScreenProfile({super.key});

  @override
  State<QuotesScreenProfile> createState() => _QuotesScreenProfileState();
}

class _QuotesScreenProfileState extends State<QuotesScreenProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          // Background image
          Image.network(
            Images.img3,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),

          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(170),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E2730),
                  Color(0xFF000000),
                  Color(0xFF11171C).withAlpha(204),
                  Color(0xFF11171C),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
            ).copyWith(top: 64),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.network(Images.img6, height: 35, width: 35),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Grane Smith",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 280, left: 23, right: 23),
            child: Text(
              LoremIpsum.p5,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Plus Jakarta Sans",
                fontWeight: FontWeight.w800,
                fontSize: 32,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          // Bottom bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 27,
              ).copyWith(bottom: 44),
              decoration: BoxDecoration(),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.alarm_rounded, color: Colors.white),
                      SizedBox(height: 4),
                      Text(
                        "Set alarm",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Plus Jakarta Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.bookmark_border, color: Colors.white),
                      SizedBox(height: 4),
                      Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Plus Jakarta Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.volume_up_outlined, color: Colors.white),
                      SizedBox(height: 4),
                      Text(
                        "Listen",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Plus Jakarta Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.favorite_border, color: Colors.white),
                      SizedBox(height: 4),
                      Text(
                        "Like",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Plus Jakarta Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
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
