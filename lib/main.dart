import 'package:flutter/material.dart';
import 'dart:async'; // Import this for Timer
import 'game_utils.dart';
import 'info_card.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle whiteText = const TextStyle(color: Colors.white);
  bool hideTest = false;
  Game _game = Game();

  // Game stats
  int attempts = 0;
  int points = 0;
  int elapsedSeconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _game.initGame();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void resetGame() {
    setState(() {
      _timer?.cancel();
      _game = Game();
      _game.initGame();
      attempts = 0;
      points = 0;
      elapsedSeconds = 0;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card Matching Game"),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 21),
            const Center(
              child: Text(
                "Card Matching Game",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                info_card("Attempts", "$attempts"),
                info_card("Points", "$points"),
                info_card("Time", "$elapsedSeconds"),
              ],
            ),
            SizedBox(
              height: 550,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: _game.gameImg!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (points >= 600) {
                        return;
                      }
                      print(_game.matchCheck);
                      setState(() {
                        // Incrementing the clicks
                        attempts++;
                        _game.gameImg![index] = _game.cards_list[index];
                        _game.matchCheck
                            .add({index: _game.cards_list[index]});
                        print(_game.matchCheck.first);
                      });
                      if (_game.matchCheck.length == 2) {
                        if (_game.matchCheck[0].values.first ==
                            _game.matchCheck[1].values.first) {
                          print("true");
                          // Incrementing the score
                          setState(() {
                            points += 100;
                          });
                          _game.matchCheck.clear();

                          if (points == 600) {
                            _timer?.cancel();
                          }
                        } else {
                          print("false");
                          // Deducting points for mismatch
                          setState(() {
                            points = (points - 10).clamp(0, points);
                          });
                          Future.delayed(const Duration(milliseconds: 500), () {
                            print(_game.gameColors);
                            setState(() {
                              _game.gameImg![_game.matchCheck[0].keys.first] =
                                  _game.hiddenCardpath;
                              _game.gameImg![_game.matchCheck[1].keys.first] =
                                  _game.hiddenCardpath;
                              _game.matchCheck.clear();
                            });
                          });
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_game.gameImg![index]),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            points == 600
                ? ElevatedButton(
                    onPressed: resetGame,
                    child: const Text('Play Again?'),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
