import 'package:flutter/material.dart';

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
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => action(),
        child: SizedBox(
          height: 50,
          width: 100,
          child: Center(
            child: Text(
              label!,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
