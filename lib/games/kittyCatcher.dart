import 'dart:math';
import 'package:flutter/material.dart';

class KittyCatcher extends StatefulWidget {
  const KittyCatcher({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<KittyCatcher> {
  double _catPositionX = 0;
  double _catPositionY = 0;
  int _score = 0;
  final bool _showTapped = false;

  int _randomIndex = 0;

  get random => null;

  void _updateCatPosition() {
    setState(() {
      Random random = Random();
      _catPositionX =
          random.nextDouble() * 0.9 * (MediaQuery.of(context).size.width);
      _catPositionY =
          random.nextDouble() * 0.8 * (MediaQuery.of(context).size.height);
      _randomIndex = random.nextInt(imageList.length);
    });
  }

  void _onTapCat() {
    setState(() {
      _score++;
      _updateCatPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitty Catcher'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: _catPositionX,
            top: _catPositionY,
            child: GestureDetector(
              onTap: _onTapCat,
              child:
                  Image.asset(imageList[_randomIndex], width: 100, height: 100),
            ),
          ),
          // if (_showTapped) ...[
          //   Positioned(
          //     left: _catPositionX,
          //     top: _catPositionY,
          //     child: const Text('Bunched'),
          //   ),
          // ],
          Positioned(
            top: 20,
            right: 20,
            child: Text('Score: $_score', style: const TextStyle(fontSize: 24)),
          ),
        ],
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
