import 'package:flutter/material.dart';

// Turn into IconButton -> Check if it makes sense
class RecordManagementButton extends StatelessWidget {
  final Icon icon;

  const RecordManagementButton(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white24,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () {},
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: icon,
        ),
      ),
    );
  }
}
