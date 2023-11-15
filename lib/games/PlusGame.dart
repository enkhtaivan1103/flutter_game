import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const PlusMatchGame());

class PlusMatchGame extends StatelessWidget {
  const PlusMatchGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Plus Equation Match Game',
      home: PlusMatchGamePage(),
    );
  }
}

class PlusMatchGamePage extends StatefulWidget {
  const PlusMatchGamePage({super.key});

  @override
  _PlusMatchGamePageState createState() => _PlusMatchGamePageState();
}

class _PlusMatchGamePageState extends State<PlusMatchGamePage> {
  final Random random = Random();

  late int firstNumber;
  late int secondNumber;
  late int correctAnswer;

  int score = 0;
  int incorrectAttempts = 0;

  List<int> answerChoices = [];

  void _generateEquation() {
    setState(() {
      firstNumber = random.nextInt(10) + 1;
      secondNumber = random.nextInt(10) + 1;
      correctAnswer = firstNumber + secondNumber;

      answerChoices.clear();
      answerChoices.add(correctAnswer);

      while (answerChoices.length < 4) {
        int randomNumber = random.nextInt(19) + 2;
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
        title: const Text('Plus Equation Match Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$firstNumber + $secondNumber = ?',
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
