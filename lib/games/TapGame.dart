import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import '/startPage.dart';
import 'package:audioplayers/audioplayers.dart';

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
  double _right = 0.0;
  double _fallingSpeed = 1.0;
  String _fallSpeedCounter = '0.0';
  int _score = 0;
  int _heart = 5;
  final Random _random = Random();
  int _randomIndex = 0;

  double _width = 80;
  double _height = 80;

  final _player = AudioPlayer();

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
          _fallSpeedCounter = _fallingSpeed.toStringAsFixed(1);
          if (_top > MediaQuery.of(context).size.height) {
            _top = -80;
            _left = _random.nextDouble() * MediaQuery.of(context).size.width;
            // _right = _random.nextDouble() * MediaQuery.of(context).size.width;
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
        _left = _random.nextDouble() * MediaQuery.of(context).size.width;
        // _right = _random.nextDouble() * MediaQuery.of(context).size.width;
        _randomIndex = random.nextInt(imageList.length);
      });
      _animation;
      _player.play(AssetSource('audio/target_click.wav'));
    }
  }

  void _restartGame() {
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {
      Random random = Random();
      _heart = 5;
      _top = -80;
      _left = _random.nextDouble() * MediaQuery.of(context).size.width - 40;
      _randomIndex = random.nextInt(imageList.length);
    });
    _controller.repeat();
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 7,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          title: Text(
            'GAME IS OVER!',
            style: GoogleFonts.righteous(
              textStyle: const TextStyle(
                color: Colors.black,
                letterSpacing: .5,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: Text(
            'YOUR SCORE: $_score',
            style: GoogleFonts.righteous(
              textStyle: const TextStyle(
                color: Colors.black,
                letterSpacing: .5,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const StartPage()),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: const Text('Exit'),
            ),
            FilledButton(
              onPressed: _restartGame,
              child: const Text('Continue'),
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
              image: AssetImage('lib/assets/backgroundCity.gif'),
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
                      width: _width, height: _height)),
              Positioned(
                top: 50.0,
                right: 20.0,
                child: Text(
                  'Score: $_score',
                  style: GoogleFonts.righteous(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70.0,
                right: 20.0,
                child: Text(
                  'Heart: $_heart',
                  style: GoogleFonts.righteous(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70.0,
                left: 20.0,
                child: Text(
                  'Speed: $_fallSpeedCounter',
                  style: GoogleFonts.righteous(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: 20,
                    ),
                  ),
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
  'lib/assets/cat_1.jpg',
  'lib/assets/cat_2.jpg',
  'lib/assets/cat_3.jpg',
  'lib/assets/cat_4.jpg',
  'lib/assets/cat_5.jpg',
  'lib/assets/cat_6.jpg',
  'lib/assets/cat_7.jpg',
  'lib/assets/cat_8.jpg',
  'lib/assets/cat_9.jpg',
];
