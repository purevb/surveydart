import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey/animation.dart';
import 'package:survey/pages/login_page/login_page.dart';
import 'package:survey/pages/survey/new_home_page.dart';
// import 'package:survey/provider/question_provider.dart';
import 'package:survey/provider/save_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => QuestionProvider()),
        ChangeNotifierProvider(create: (context) => SaveProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        //  LoginPage(),
      ),
    );
  }
}
