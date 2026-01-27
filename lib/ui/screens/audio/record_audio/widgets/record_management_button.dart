import 'package:flutter/material.dart';

// Turn into IconButton -> Check if it makes sense
class RecordManagementButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback action;
  final bool disabled;

  const RecordManagementButton(
    this.icon,
    this.action, {
    super.key,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 400),
        opacity: (disabled) ? 0 : 1,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white24,
            shape: BoxShape.circle,
          ),
          child: IconButton(onPressed: () => action(), icon: icon),
        ),
      ),
    );
  }
}
