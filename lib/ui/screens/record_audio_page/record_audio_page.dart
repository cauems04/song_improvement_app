import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/play_options_page/widgets/denied_permission_modal.dart';
import 'package:guitar_song_improvement/ui/screens/record_audio_page/widgets/wait_time_picker.dart';

class RecordAudioPage extends StatefulWidget {
  const RecordAudioPage({super.key});

  @override
  State<RecordAudioPage> createState() => _RecordAudioPageState();
}

class _RecordAudioPageState extends State<RecordAudioPage> {
  late bool isActive;
  late int secondsToStart;

  @override
  void initState() {
    isActive = false;
    secondsToStart = 0; // Implement with caching later
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.close),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: (isActive)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainerLowest,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Icon(Icons.mic, size: 80),
                ),
              ),
            ),
            SafeArea(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(child: WaitTimePicker());
                        },
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLow,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${secondsToStart}s",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
