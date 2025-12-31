import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/music_provider.dart';
import 'package:guitar_song_improvement/ui/screens/home_page/home_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<MusicProvider>(
        builder: (context, data, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (data.isLoaded) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()),
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
