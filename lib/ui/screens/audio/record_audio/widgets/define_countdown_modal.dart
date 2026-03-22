import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/dark_theme.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';

class DefineCountdownModal extends StatefulWidget {
  final RecordAudioViewmodel recordAudioVM;

  const DefineCountdownModal(this.recordAudioVM, {super.key});

  @override
  State<DefineCountdownModal> createState() => _DefineCountdownModalState();
}

class _DefineCountdownModalState extends State<DefineCountdownModal> {
  late int seconds;

  @override
  void initState() {
    super.initState();
    seconds = widget.recordAudioVM.countdownNumberDefined.value;
  }

  void incrementCountdown() {
    setState(() {
      if (seconds < 20) seconds++;
    });
  }

  void decrementCountdown() {
    setState(() {
      if (seconds > 0) seconds--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Container(
        padding: const EdgeInsets.all(Spacing.lg),
        height: 350,
        decoration: BoxDecoration(
          color: DarkThemeColors.defaultModal,
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: Spacing.xs),
                          child: Icon(
                            Icons.timer_outlined,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "Countdown Timer",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              "Set seconds to wait before recording starts",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.white70),
            ),
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: DarkThemeColors.defaultModalDark,
                border: Border.all(color: Colors.white12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => decrementCountdown(),
                    icon: Icon(Icons.remove, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: DarkThemeColors.defaultModal,
                      iconSize: 40,
                    ),
                  ),
                  Text(
                    seconds.toString(),
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(fontSize: 34),
                  ),
                  IconButton(
                    onPressed: () => incrementCountdown(),
                    icon: Icon(Icons.add, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: DarkThemeColors.defaultModal,
                      iconSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            _ConfirmButtom(
              () => widget.recordAudioVM.setCoundownNumber = seconds,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmButtom extends StatelessWidget {
  final VoidCallback action;

  const _ConfirmButtom(this.action);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary.withAlpha(180),
              ],
            ),
          ),
          child: Center(
            child: Text(
              "Save",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        onTap: () {
          action();
          Navigator.pop(context);
        },
      ),
    );
  }
}
