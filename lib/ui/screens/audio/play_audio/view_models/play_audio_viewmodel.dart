import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class PlayAudioViewmodel {
  late final AudioPlayer _audioPlayer = AudioPlayer();
  late final String _audioFilePath;

  late ValueNotifier<ProcessingState> playingState;
  late ValueNotifier<bool> isPlaying;

  void initValues(audioFilePath) {
    _audioFilePath = audioFilePath;
    _audioPlayer.setAudioSource(AudioSource.file(_audioFilePath));
    playingState = ValueNotifier(_audioPlayer.processingState);
    isPlaying = ValueNotifier(_audioPlayer.playing);

    _audioPlayer.processingStateStream.listen((state) {
      playingState.value = state;
    });

    _audioPlayer.playingStream.listen((playing) {
      isPlaying.value = playing;
    });
  }

  Future<void> playAudio() async {
    switch (playingState.value) {
      case ProcessingState.ready:
        if (!_audioPlayer.playing) {
          _audioPlayer.play();
        } else {
          _audioPlayer.pause();
        }
        break;
      case ProcessingState.completed:
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.play();
        break;
      default:
        break;
    }
  }

  Future<void> skipDuration({bool backwards = false}) async {
    (backwards)
        ? _audioPlayer.seek(_audioPlayer.position - Duration(seconds: 5))
        : _audioPlayer.seek(_audioPlayer.position + Duration(seconds: 5));
  }
}
