import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/screens/components/box_form.dart';
import 'package:guitar_song_improvement/screens/save_link_page.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class LinkCard extends StatelessWidget {
  final Link link;

  const LinkCard(this.link, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(
        Spacing.md,
        Spacing.xs,
        Spacing.xs,
        Spacing.xs,
      ),
      child: Material(
        child: InkWell(
          child: BoxForm(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text(link.title), Text(link.url)],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SaveLinkPage(link: link, isEditing: true),
              ),
            );
          },
        ),
      ),
    );
  }
}
