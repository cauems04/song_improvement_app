import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/screens/save_song_page.dart';

class AddNewSongButton extends StatelessWidget {
  const AddNewSongButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(206, 160, 221, 1),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 200,
          height: 34,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.add), Text("Create a new")],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SaveSongPage()),
          );
        },
      ),
    );
  }
}
