import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_game/games/attribution_screen.dart';
import 'package:flutter_game/games/TapGame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

final player = AudioPlayer();
bool music = true;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void initState() {
    super.initState();
    _startBgMusic();
  }

  _startBgMusic() {
    player.play(AssetSource('audio/startPage_background.mp3'));
    setState(() {
      music = true;
    });
  }

  _pauseBgMusic() {
    player.pause();
    setState(() {
      music = false;
    });
    print('$music PUASED');
  }

  _resumeBgMusic() {
    player.resume();
    setState(() {
      music = true;
    });
    print('$music RESUMED');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        print('didpop $didPop');
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 26, 31, 36),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 179, 204),
                Color.fromARGB(255, 243, 255, 203),
                Color.fromARGB(255, 246, 91, 160),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/hand_only.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '~ Lets catch the kitties  ~',
                        style: GoogleFonts.justAnotherHand(
                          textStyle: const TextStyle(
                              color: const Color.fromARGB(255, 206, 3, 95),
                              letterSpacing: 2,
                              fontSize: 52,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 206, 3, 95),
                          // shadowColor: Colors.red,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          minimumSize: const Size(240, 72),
                        ),
                        child: Text(
                          '~ Start Game ~',
                          style: GoogleFonts.justAnotherHand(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontSize: 52,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          _pauseBgMusic();
                          String refresh = await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const TapGame()),
                              fullscreenDialog: true,
                            ),
                          );
                          if (refresh == 'refresh') {
                            await _startBgMusic();
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextButton(
                        child: Text(
                          'Go to About ->',
                          style: GoogleFonts.justAnotherHand(
                            textStyle: const TextStyle(
                                color: const Color.fromARGB(255, 206, 3, 95),
                                letterSpacing: 1,
                                fontSize: 32,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const AttributionScreen()),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'lib/assets/coffee_cat.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                  Column(
                    children: [
                      music
                          ? Padding(
                              padding: const EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.music_note),
                                onPressed: () {
                                  _pauseBgMusic();
                                },
                                iconSize: 25,
                                color: Color.fromARGB(255, 206, 3, 95),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.music_off),
                                onPressed: () {
                                  _resumeBgMusic();
                                },
                                iconSize: 25,
                                color: Color.fromARGB(255, 206, 3, 95),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                          right: 10,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.info),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                    const AttributionScreen()),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          iconSize: 25,
                          color: Color.fromARGB(255, 206, 3, 95),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
