import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/screens/search_page.dart';

class SearchSong extends StatelessWidget {
  final String hint;

  const SearchSong(this.hint, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          style: TextStyle(color: Colors.white),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, size: 20, color: Colors.white),
            hintText: hint,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            labelStyle: TextStyle(color: Colors.white),
            isDense: true,
          ),
          onSubmitted: (value) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => SearchPage()));
          },
        ),
      ),
    );
  }
}
