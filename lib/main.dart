import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Pages/add_quote_screen.dart';
import 'package:sports_app/Presentation/Pages/detail_quotes.dart';
import 'package:sports_app/Presentation/Pages/edit_profile_screen.dart';
import 'package:sports_app/Presentation/Pages/explore_feed.dart';
import 'package:sports_app/Presentation/Pages/home_screen.dart';
import 'package:sports_app/Presentation/Pages/onboarding1.dart';
import 'package:sports_app/Presentation/Pages/onboarding2.dart';
import 'package:sports_app/Presentation/Pages/onboarding3.dart';
import 'package:sports_app/Presentation/Pages/profile_screen.dart';
import 'package:sports_app/Presentation/Pages/progress.dart';
import 'package:sports_app/Presentation/Pages/questions_level_screen.dart';
import 'package:sports_app/Presentation/Pages/quotes_preference.dart';
import 'package:sports_app/Presentation/Pages/quotes_screen.dart';
import 'package:sports_app/Presentation/Pages/quotes_screen2.dart';
import 'package:sports_app/Presentation/Pages/quotes_screen_profile.dart';
import 'package:sports_app/Presentation/Pages/saved_quotes.dart';
import 'package:sports_app/Presentation/Pages/select_question_screen.dart';
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
      home: Progress(),
    );
  }
}
