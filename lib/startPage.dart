<<<<<<< HEAD
import './games/ColorTap.dart';
import './games/TapGame.dart';
import './games/kittyCatcher.dart';
import './games/PlusGame.dart';
import './games/MinusGame.dart';
=======
import 'package:google_fonts/google_fonts.dart';
>>>>>>> 0c193c2381f127c83219146f4587f74f6cafe2f5
import 'package:flutter/material.dart';
import 'package:tapgame/games/PlusGame.dart';

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
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shadowColor: Colors.red,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  minimumSize: const Size(280, 68),
                ),
                child: Text(
                  'Start Game',
                  style: GoogleFonts.righteous(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: 34,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const PlusMatchGame()),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
