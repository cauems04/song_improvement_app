import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/screens/home_page.dart';
import 'package:guitar_song_improvement/screens/save_song_page.dart';
import 'package:guitar_song_improvement/screens/search_page.dart';
import 'package:guitar_song_improvement/screens/song_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guitar Improving',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SongPage("I Wanna Be Yours", "Arctic Monkeys", "AM"),
    );
  }
}
