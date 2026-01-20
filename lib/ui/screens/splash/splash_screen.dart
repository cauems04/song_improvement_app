import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<MusicProvider>(
        builder: (context, data, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (data.isLoaded) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else {
              data.getData();
            }
          });

          return Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.bottomLeft,
                end: AlignmentGeometry.topRight,
                colors: [
                  Colors.blue,
                  Colors.purple,
                  Colors.cyan,
                  Colors.purpleAccent,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.music_note, size: 80),
          );
        },
      ),
    );
  }
}
