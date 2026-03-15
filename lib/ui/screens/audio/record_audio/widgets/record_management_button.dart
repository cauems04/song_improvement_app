import 'package:flutter/material.dart';

class RecordUtilButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const RecordUtilButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerLowest.withAlpha(100),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}

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

class RecordButton extends StatelessWidget {
  final bool isRecording;
  final Function() onTap;

  const RecordButton({
    super.key,
    required this.isRecording,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 94,
        width: 94,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: (!isRecording)
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.redAccent,
            width: 3,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: (!isRecording) ? 60 : 40,
            width: (!isRecording) ? 60 : 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (!isRecording) ? Colors.white : Colors.redAccent,
              border: (!isRecording)
                  ? Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 3,
                    )
                  : null,
              boxShadow: (!isRecording)
                  ? [
                      BoxShadow(
                        color: (!isRecording)
                            ? Theme.of(context).colorScheme.primary
                            : Colors.redAccent,
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
