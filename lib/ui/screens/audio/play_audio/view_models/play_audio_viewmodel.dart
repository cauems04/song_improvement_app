import 'package:just_audio/just_audio.dart';

class PlayAudioViewmodel {
  late final AudioPlayer _audioPlayer = AudioPlayer();
  late final String _audioFilePath;

  bool isPlaying = false;

  void initValues(audioFilePath) {
    _audioFilePath = audioFilePath;
    _audioPlayer.setAudioSource(AudioSource.file(_audioFilePath));
  }

  void playAudio() async {
    if (!isPlaying) {
      await _audioPlayer.play();
    } else {
      await _audioPlayer.stop();
    }

    isPlaying = !isPlaying;
  }
}
