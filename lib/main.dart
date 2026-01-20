import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/ui/screens/splash/splash_screen.dart';
import 'package:guitar_song_improvement/themes/dark_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guitar Improving',
      theme: appTheme,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
