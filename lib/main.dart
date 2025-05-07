import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Pages/onboarding1.dart';
import 'package:sports_app/Presentation/Pages/onboarding2.dart';
import 'package:sports_app/Presentation/Pages/onboarding3.dart';
import 'package:sports_app/Presentation/Pages/sign_in.dart';
import 'package:sports_app/Presentation/Pages/sign_up.dart';
import 'package:sports_app/Presentation/Pages/skip_page.dart';
import 'package:sports_app/Presentation/Pages/splash_screen.dart';
import 'package:sports_app/firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
 );
 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {'/home': (context) => Onboarding2()},
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SignUp(),
    );
  }
}
