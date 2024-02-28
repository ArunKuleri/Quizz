import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/provider/gamePageProvider.dart';

class GamePage extends StatelessWidget {
  final String difficultyLevel;
  double? width, height;
  GamePageProvider? _pageProvider;
  GamePage({required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) =>
          GamePageProvider(context: context, difficultyLevel: difficultyLevel),
      child: _buildUi(),
    );
  }

  Widget _buildUi() {
    return Builder(builder: (context) {
      _pageProvider = context.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
              child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: height! * 0.05),
              child: _gameUi(),
            ),
          )),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    });
  }

  Widget _gameUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: height! * 0.01,
            ),
            _falseButton(),
          ],
        )
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQuestionText(),
      style: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: width! * 0.80,
      height: height! * 0.10,
      child: Text(
        "True",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: width! * 0.80,
      height: height! * 0.10,
      child: Text(
        "Flase",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
