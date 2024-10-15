import 'package:flutter/material.dart';

Widget info_card(String title, String info) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(8.0), // Reduced margin to fit more cards
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0, // Reduced font size
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            info,
            style: const TextStyle(
              fontSize: 28.0, // Reduced font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
