import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SessionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SessionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: Spacing.xs),
            child: Icon(icon, size: 36, color: Colors.white60),
          ),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
