import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/screens/components/box_form.dart';

class LinkCard extends StatelessWidget {
  final Link link;

  const LinkCard(this.link, {super.key});

  @override
  Widget build(BuildContext context) {
    return BoxForm(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text(link.title), Text(link.url)],
      ),
    );
  }
}
