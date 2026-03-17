import 'package:flutter/material.dart';

class RecordUtilButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const RecordUtilButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTap,
      icon: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
      style: IconButton.styleFrom(
        iconSize: 30,
        backgroundColor: Colors.white10,
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

// class RecordUtilButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const RecordUtilButton({super.key, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       width: 50,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Theme.of(
//           context,
//         ).colorScheme.surfaceContainerLowest.withAlpha(100),
//         border: Border.all(
//           color: Theme.of(context).colorScheme.surfaceContainerLow,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Center(
//         child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
//       ),
//     );
//   }
// }

// Turn into IconButton -> Check if it makes sense
class RecordManagementButtona extends StatelessWidget {
  final Icon icon;
  final VoidCallback action;
  final bool disabled;

  const RecordManagementButtona(
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
