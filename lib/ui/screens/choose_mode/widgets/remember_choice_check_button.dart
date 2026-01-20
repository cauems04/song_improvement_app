import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class RememberCoiceCheckButtom extends StatelessWidget {
  final Function() onTap;
  final bool rememberChoice;

  const RememberCoiceCheckButtom(this.rememberChoice, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          child: rememberChoice
              ? Icon(Icons.check_box, size: 30, color: Colors.lightGreenAccent)
              : Icon(Icons.check_box_outline_blank, size: 30),
          onTap: () => onTap(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Spacing.md),
          child: Text(
            "Remember choice",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
