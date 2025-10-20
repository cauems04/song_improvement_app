import 'package:flutter/material.dart';

class FilterOption extends StatelessWidget {
  final String label;

  const FilterOption(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 16, width: 24, child: Text(label));
  }
}
