import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/save_song/save_song_screen.dart';

class AddNewSongButton extends StatelessWidget {
  const AddNewSongButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.add), Text("Create a new")],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SaveSongScreen()),
          );
        },
      ),
    );
  }
}
