import 'package:flutter/material.dart';

String BASE_URL =  "https://quotable.vercel.app";
int Quote_Limit = 5;

List<Map<String, dynamic>> moods = [
  {
    "label": "Suffering :)",
    "emoji": "💔",
    "color": Colors.deepPurple.shade200,
  },
  {
    "label": "baddd",
    "emoji": "🫠",
    "color": Colors.deepOrangeAccent,
  },
  {
    "label": "meh -_-",
    "emoji": "🙃",
    "color": Colors.blueGrey.shade400,
  },
  {
    "label": "good",
    "emoji": "😌",
    "color": Colors.lightGreen.shade400,
  },
  {
    "label": "happy happy happy",
    "emoji": "😎✨",
    "color": Colors.amberAccent.shade400,
  },
];

Color getMoodColor(String mood) {
  return moods.firstWhere((element) => element['label'] == mood)['color'];
}

