import 'package:flutter/material.dart';
import 'package:quizz/pages/GamePage.dart';
import 'package:quizz/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: Color.fromARGB(255, 55, 57, 58),
          useMaterial3: true,
        ),
        home: HomePage());
  }
}
