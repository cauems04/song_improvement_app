import 'package:flutter/material.dart';

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
