import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/song/base_song/widgets/nav_element.dart';

class TopNavigationBar extends StatelessWidget {
  final int currentPage;

  final Function(int) onTap;

  const TopNavigationBar(this.currentPage, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NavElement(0, "Links", currentPage: currentPage, onTap: onTap),
        NavElement(1, "Overview", currentPage: currentPage, onTap: onTap),
        NavElement(2, "Records", currentPage: currentPage, onTap: onTap),
      ],
    );
  }
}
