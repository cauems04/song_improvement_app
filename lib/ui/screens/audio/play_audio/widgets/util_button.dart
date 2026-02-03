import 'package:flutter/material.dart';

// Turn into a general widget
class UtilButton extends StatelessWidget {
  final Icon icon;
  final bool isPlay;
  final VoidCallback onPressed;

  const UtilButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isPlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (isPlay)
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: IconButton(
        onPressed: () => onPressed(),
        icon: icon,
        highlightColor: Colors.white,
      ),
    );
  }
}
