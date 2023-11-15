import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MinusMatchGame());

class MinusMatchGame extends StatelessWidget {
  const MinusMatchGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Minus Equation Match Game',
      home: MinusMatchGamePage(),
    );
  }
}

class MinusMatchGamePage extends StatefulWidget {
  const MinusMatchGamePage({Key? key}) : super(key: key);

  @override
  _MinusMatchGamePageState createState() => _MinusMatchGamePageState();
}

class _MinusMatchGamePageState extends State<MinusMatchGamePage> {
  final Random random = Random();

  late int firstNumber;
  late int secondNumber;
  late int correctAnswer;

  int score = 0;
  int incorrectAttempts = 0;

  List<int> answerChoices = [];

  void _generateEquation() {
    setState(() {
      firstNumber = random.nextInt(20) + 1;
      secondNumber = random.nextInt(firstNumber) + 1;
      correctAnswer = firstNumber - secondNumber;

      answerChoices.clear();
      answerChoices.add(correctAnswer);

      while (answerChoices.length < 4) {
        int randomNumber = random.nextInt(39) + 2;
        if (!answerChoices.contains(randomNumber)) {
          answerChoices.add(randomNumber);
        }
      }
      answerChoices.shuffle();
    });
  }

  void _checkAnswer(int selectedAnswer) {
    if (selectedAnswer == correctAnswer) {
      setState(() {
        score++;
      });
    } else {
      setState(() {
        incorrectAttempts++;
      });
    }
    _generateEquation();
  }

  @override
  void initState() {
    super.initState();
    _generateEquation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minus Equation Match Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$firstNumber - $secondNumber = ?',
              style: const TextStyle(fontSize: 32.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: answerChoices.map((answer) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    child: Text(answer.toString()),
                    onPressed: () => _checkAnswer(answer),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Score: $score / Incorrect Attempts: $incorrectAttempts',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
