import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Pages/onboarding1.dart';
import 'package:sports_app/Presentation/Pages/onboarding2.dart';
import 'package:sports_app/Presentation/Pages/onboarding3.dart';
import 'package:sports_app/Presentation/Pages/skip_page.dart';
import 'package:sports_app/Presentation/Pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
      '/home':(context)=>Onboarding2(),
      },
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
