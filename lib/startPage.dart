import './games/ColorTap.dart';
import './games/TapGame.dart';
import './games/kittyCatcher.dart';
import './games/PlusGame.dart';
import './games/MinusGame.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPage'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Kitty Catcher'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const KittyCatcher())),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Color Tap'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const ColorTap())),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Tap Game'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const TapGame())),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Plus Game'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const PlusMatchGame())),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Minus Game'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const MinusMatchGame())),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
