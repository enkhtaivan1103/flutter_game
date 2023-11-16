import './games/ColorTap.dart';
import './games/TapGame.dart';
import './games/kittyCatcher.dart';
import './games/PlusGame.dart';
import './games/MinusGame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import './games/PlusGame.dart';
import 'package:audioplayers/audioplayers.dart';

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
        // backgroundColor: Color.fromARGB(255, 57, 212, 194),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 26, 31, 36),
            // image: DecorationImage(
            //   fit: BoxFit.fitWidth,
            //   image: Image.asset(
            //     'lib/assets/backgroundCity.gif',
            //   ).image,
            // ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 206, 3, 95),
                    // shadowColor: Colors.red,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    minimumSize: const Size(240, 68),
                  ),
                  child: Text(
                    'Start Game',
                    style: GoogleFonts.righteous(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const TapGame()),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 206, 3, 95),
                    // shadowColor: Colors.red,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    minimumSize: const Size(240, 68),
                  ),
                  child: Text(
                    'Make a Sound',
                    style: GoogleFonts.righteous(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final player = AudioPlayer();
                    await player.play(AssetSource('audio/empty_click.wav'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
