import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import '/startPage.dart';

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
  double _fallingSpeed = 5.0;
  String _fallSpeedCounter = '0.0';
  int _score = 0;
  int _heart = 5;
  int _try = 2;
  int _calculatedScore = 0;
  final Random _random = Random();
  int _randomIndex = 0;

  String _backgroundImg = 'lib/assets/bg_3.gif';
  bool _stopped = false;

  final double _width = 80;
  final double _height = 80;

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
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
            _player.play(AssetSource('audio/empty_click.wav'));
          }
          if (_heart == 0) {
            _controller.stop();
            _showFinishDialog();
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
        details.localPosition.dx <= _left + 80 &&
        details.localPosition.dy >= _top &&
        details.localPosition.dy <= _top + 80.0) {
      setState(() {
        Random random = Random();
        _score++;
        _fallingSpeed += 0.2;
        _top = -80;
        _left =
            (_random.nextDouble() - 0.1) * MediaQuery.of(context).size.width;
        // _right = _random.nextDouble() * MediaQuery.of(context).size.width;
        _randomIndex = random.nextInt(imageList.length);
        _calculatedScore = _score * _fallingSpeed.round();
      });
      _animation;
      _player.play(AssetSource('audio/target_click.wav'));
      _backgroundImageChanger();
    }
  }

  void _onTapPause() {
    _controller.stop();
    setState(() {
      _stopped = true;
      _showPauseDialog();
    });
  }

  void _onTapPlay() {
    Navigator.of(context, rootNavigator: true).pop();
    _controller.repeat();
    setState(() {
      _stopped = false;
    });
  }

  void _restartGame() {
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {
      Random random = Random();
      _heart = 5;
      _top = -80;
      _left = (_random.nextDouble() * MediaQuery.of(context).size.width) - 40;
      _randomIndex = random.nextInt(imageList.length);
    });
    _controller.repeat();
    _try -= 1;
  }

  void _backgroundImageChanger() {
    setState(() {
      if (_calculatedScore > 1000) {
        _backgroundImg = 'lib/assets/bg_2.gif';
      }
      if (_calculatedScore > 2000) {
        _backgroundImg = 'lib/assets/bg_1.gif';
      }
      if (_calculatedScore > 3000) {
        _backgroundImg = 'lib/assets/bg_3.gif';
      }
    });
  }

  void _showFinishDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 7,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(26.0),
            ),
          ),
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
          content: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'YOUR SCORE: $_calculatedScore',
                    style: GoogleFonts.righteous(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (_try > 0)
                    Text(
                      'You can try $_try more',
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          letterSpacing: .5,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const StartPage()),
                    fullscreenDialog: true,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 57, 210, 192),
                // shadowColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                minimumSize: const Size(100, 40),
              ),
              child: const Text(
                'Exit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            if (_try > 0) const SizedBox(width: 8.0),
            if (_try > 0)
              ElevatedButton(
                onPressed: _restartGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 206, 3, 95),
                  // shadowColor: Colors.red,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  minimumSize: const Size(100, 40),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            const SizedBox(
              height: 40,
            )
          ],
        );
      },
    );
  }

  void _showPauseDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 7,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(26.0),
            ),
          ),
          title: Text(
            'GAME PAUSED!',
            style: GoogleFonts.righteous(
              textStyle: const TextStyle(
                color: Colors.black,
                letterSpacing: .5,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Wait... Take a rest! You can do it...',
                    style: GoogleFonts.righteous(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const StartPage()),
                    fullscreenDialog: true,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 57, 210, 192),
                // shadowColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                minimumSize: const Size(100, 40),
              ),
              child: const Text(
                'Exit',
              ),
            ),
            ElevatedButton(
              onPressed: _onTapPlay,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 206, 3, 95),
                // shadowColor: Colors.red,
                elevation: 7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                minimumSize: const Size(100, 40),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(_backgroundImg), fit: BoxFit.cover),
      ),
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
                    width: _width, height: _height),
              ),
              Positioned(
                top: 88.0,
                left: 20.0,
                child: Text(
                  'Score: $_calculatedScore',
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
                top: 112.0,
                left: 20.0,
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 206, 3, 95),
                      size: 20.0,
                    ),
                    Text(
                      ': $_heart',
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 64.0,
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
              if (!_stopped)
                Positioned(
                  top: 64,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      _onTapPause();
                    },
                    iconSize: 30,
                    color: Color.fromARGB(255, 206, 3, 95),
                  ),
                ),
              if (_stopped)
                Positioned(
                  top: 64,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      _onTapPlay();
                    },
                    iconSize: 30,
                    color: Color.fromARGB(255, 206, 3, 95),
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
