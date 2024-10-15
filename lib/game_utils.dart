import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue,
    Colors.red,
    Colors.red,
    Colors.white,
    Colors.white,
  ];
  final String hiddenCardpath = "assets/images/hidden.png";
  List<String> cards_list = [
    "assets/images/ace.png",
    "assets/images/ten.png",
    "assets/images/queen.png",
    "assets/images/jack.png",
    "assets/images/joker.png",
    "assets/images/king.png",
    "assets/images/joker.png",
    "assets/images/jack.png",
    "assets/images/ace.png",
    "assets/images/queen.png",
    "assets/images/ten.png",
    "assets/images/king.png",
  ];
  final int cardCount = 12;
  List<Map<int, String>> matchCheck = [];

  // Methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
