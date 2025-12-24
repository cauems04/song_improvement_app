import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:permission_handler/permission_handler.dart';

class DeniedPermissionModel extends StatelessWidget {
  final bool isPermanentlyDenied;

  const DeniedPermissionModel({super.key, this.isPermanentlyDenied = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.md),
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        border: Border.all(color: Colors.yellow[200]!, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.xs),
                child: Icon(Icons.mic_off, color: Colors.yellow[200], size: 50),
              ),
              Text(
                "Microphone Access Denied",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: Spacing.xl, bottom: Spacing.xl),
            child: Text(
              (isPermanentlyDenied)
                  ? "Permission to record audio was permanently denied, enable it on the device's settings"
                  : "The app must have access to the microphone to record audio",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _ConfirmButtom(isPermanentlyDenied),
        ],
      ),
    );
  }
}

class _ConfirmButtom extends StatelessWidget {
  final bool isPermanentlyDenied;

  const _ConfirmButtom(this.isPermanentlyDenied, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.yellow[700],
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              (isPermanentlyDenied) ? "Go to Settings" : "Grant Permission",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        onTap: () {
          (isPermanentlyDenied)
              ? openAppSettings()
              : Permission.microphone.request();

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
