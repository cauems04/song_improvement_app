import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/define_countdown_modal.dart';

class ConfigUtilButton extends StatelessWidget {
  final RecordAudioViewmodel recordAudioVM;
  final IconData icon;
  final String label;

  const ConfigUtilButton(
    this.recordAudioVM, {
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white38),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => showDialog(
          context: context,
          builder: (context) =>
              Center(child: DefineCountdownModal(recordAudioVM)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: SizedBox(
            height: 30,
            width: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 18,
                ),
                Text(label, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
