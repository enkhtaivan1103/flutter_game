import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const TapGame());

class TapGame extends StatelessWidget {
  const TapGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Game',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _top = 0.0;
  double _left = 0.0;
  double _fallingSpeed = 10.0;
  int _score = 0;
  int _heart = 5;
  final Random _random = Random();
  int _randomIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 10.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _top += _fallingSpeed;
          if (_top > MediaQuery.of(context).size.height) {
            _top = -80;
            _left = _random.nextDouble() * MediaQuery.of(context).size.width;
            _heart -= 1;
          }
          if (_heart == 0) {
            _controller.stop();
            _showDialog();
          }
        });
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (details.localPosition.dx >= _left &&
        details.localPosition.dx <= _left + 80.0 &&
        details.localPosition.dy >= _top &&
        details.localPosition.dy <= _top + 80.0) {
      setState(() {
        Random random = Random();
        _score++;
        _fallingSpeed += 0.1;
        _top = -80;
        _left = _random.nextDouble() * MediaQuery.of(context).size.width - 40;
        _randomIndex = random.nextInt(imageList.length);
      });
      _animation;
    }
  }

  void _restartGame() {
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {
      Random random = Random();
      _score = 0;
      _heart = 5;
      _fallingSpeed = 10;
      _top = -80;
      _left = _random.nextDouble() * MediaQuery.of(context).size.width - 40;
      _randomIndex = random.nextInt(imageList.length);
    });
    _controller.repeat();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('GAME IS OVER!'),
          content: Text('YOUR SCORE: $_score'),
          actions: <Widget>[
            TextButton(
              onPressed: _restartGame,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/backgroundCity.gif'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTapDown: _onTapDown,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: _top,
                  left: _left,
                  child: Image.asset(imageList[_randomIndex],
                      width: 80, height: 80)),
              Positioned(
                top: 50.0,
                right: 20.0,
                child: Text(
                  'Score: $_score',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              Positioned(
                top: 70.0,
                right: 20.0,
                child: Text(
                  'Heart: $_heart',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> imageList = [
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_1.jpg',
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_2.jpg',
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_3.jpg',
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_4.jpg',
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_5.jpg',
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_6.jpg',
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_7.jpg',
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_8.jpg',
  '/Users/taivan/Desktop/AppDev/calculator/calculator/lib/assets/cat_9.jpg',
];
