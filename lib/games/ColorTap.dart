import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const ColorTap());

class ColorTap extends StatelessWidget {
  const ColorTap({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Color _currentColor;
  late int _score;

  void _changeColor() {
    setState(() {
      Random random = Random();
      _currentColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
    });
  }

  void _onTapSquare() {
    setState(() {
      _score++;
      _changeColor();
    });
  }

  @override
  void initState() {
    super.initState();
    _score = 0;
    _changeColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Tap'),
      ),
      body: GestureDetector(
        onTap: _onTapSquare,
        child: Container(
          color: _currentColor,
          child: const Center(
            child: Text(
              'Tap the square!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
