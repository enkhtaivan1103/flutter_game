import 'package:flutter/material.dart';
import 'package:flutter_game/startPage.dart';
import 'package:google_fonts/google_fonts.dart';

class AttributionScreen extends StatelessWidget {
  const AttributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 251, 253, 208),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 206, 3, 95),
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const StartPage()),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          centerTitle: true,
          toolbarHeight: 100,
          title: Text(
            'About',
            style: GoogleFonts.justAnotherHand(
              textStyle: const TextStyle(
                color: Colors.white,
                letterSpacing: 2,
                fontSize: 52,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 26, 31, 36),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 179, 204),
                Color.fromARGB(255, 243, 255, 203),
                Color.fromARGB(255, 255, 214, 170),
                Color.fromARGB(255, 246, 91, 160),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Text(
                  '~ Attributions ~',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 2,
                      fontSize: 52,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '~ Character and logo Image by Freepik',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 2,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '~ Music by nojisuma from Pixabay',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 2,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '~ Music by Grand_Project from Pixabay',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 2,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '~ Packages ~',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 2,
                      fontSize: 52,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '~ Flutter SDK',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 2,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '~ Audioplayers ^5.2.1 (https://blue-fire.xyz/)',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 2,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '~ Flutter_launcher_icons: ^0.13.1 (fluttercommunity)',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 1,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '~ Google_fonts: ^6.1.0 (JustAnotherHand)',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 1,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '~ Cupertino_icons: ^1.0.2',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 1,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '~ Deep thanks for all artists and developers attributed above.',
                  style: GoogleFonts.justAnotherHand(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 10, 4, 118),
                      letterSpacing: 1,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
