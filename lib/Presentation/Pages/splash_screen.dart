import 'dart:async' as async;

import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Widgets/splash_elevated_button.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    async.Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: Column(
        children: [
          Container(
            width: 350,
            
           
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, ).copyWith(top: 650),
              child: SplashElevatedButton(buttonText: "Get Started", width: 158, onpressed: (){}),
            ),
          ),
        ],
      ),
    );
  }
}
