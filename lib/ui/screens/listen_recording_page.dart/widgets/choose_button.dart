import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChooseButton extends StatelessWidget {
  final String? label;
  final Color color;
  final VoidCallback action;

  const ChooseButton({
    super.key,
    required this.label,
    required this.color,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          label!,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
