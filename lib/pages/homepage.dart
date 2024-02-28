import 'package:flutter/material.dart';
import 'package:quizz/pages/GamePage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  double? deviceHeight, deviceWidth;
  double _currentDifficultyLevel = 0;
  final List<String> _difficultyTexts = ["Easy", "Medium", "Hard"];
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _apptitle(),
              _difficultlySlider(),
              _startGameButton(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _apptitle() {
    return Column(
      children: [
        const Text(
          "Frivia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _difficultyTexts[_currentDifficultyLevel.toInt()],
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _difficultlySlider() {
    return Slider(
        label: "Difficulty",
        min: 0,
        max: 2,
        divisions: 2,
        value: _currentDifficultyLevel,
        onChanged: (value) {
          setState(() {
            _currentDifficultyLevel = value;
          });
        });
  }

  Widget _startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext _context) {
          return GamePage(
            difficultyLevel:
                _difficultyTexts[_currentDifficultyLevel.toInt()].toLowerCase(),
          );
        }));
      },
      color: Colors.blue,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child: const Text(
        "Start",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
