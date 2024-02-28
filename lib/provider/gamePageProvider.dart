import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int _maxQuestions = 10;

  List? questions;
  final String difficultyLevel;
  int CurrentQuestionCount = 0;
  int CorrectCount = 0;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficultyLevel}) {
    dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionFromAPI();
  }
  Future<void> _getQuestionFromAPI() async {
    print(difficultyLevel);
    var response = await dio.get(
      '',
      queryParameters: {
        'amount': 10,
        "type": 'boolean',
        'difficulty': difficultyLevel,
      },
    );
    var data = jsonDecode(
      response.toString(),
    );
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![CurrentQuestionCount]['question'];
  }

  Future<void> answerQuestion(String answer) async {
    bool isCorrect =
        questions![CurrentQuestionCount]["correct_answer"] == answer;
    CorrectCount += isCorrect ? 1 : 0;
    CurrentQuestionCount++;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if (CurrentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "End Game!",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            content: Text("$CorrectCount:0/$_maxQuestions"),
          );
        });
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
