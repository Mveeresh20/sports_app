import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Pages/sign_up.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class SkipPage extends StatefulWidget {
  const SkipPage({super.key});

  @override
  State<SkipPage> createState() => _SkipPageState();
}

class _SkipPageState extends State<SkipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: 
       
        Stack(
          children: [
            Image.network(Images.img1, fit: BoxFit.cover,height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 73, right: 3),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Row(
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
                ),
              ),
            ),
        
            Positioned(
              top: 564,
              left: 20,
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Color(0xFFFFFFFF),
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(text: "swipe up to start\n"),
                    TextSpan(
                      text: "your journey",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 32,
                        color: Color(0xFFC1232C),
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
