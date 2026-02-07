import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:just_audio/just_audio.dart';

class PlayAudioViewmodel {
  late final AudioPlayer _audioPlayer = AudioPlayer();
  late final String _audioFilePath;

  late ValueNotifier<ProcessingState> playingState;
  late ValueNotifier<bool> isPlaying;

  late ValueNotifier<Duration> currentDuration;
  late ValueNotifier<Duration> totalDuration;

  late final TextEditingController nameController;
  late final String songAlbum;
  late final String songArtist;

  void initValues(audioFilePath, Song song) {
    _audioFilePath = audioFilePath;
    _audioPlayer.setAudioSource(AudioSource.file(_audioFilePath));

    playingState = ValueNotifier(_audioPlayer.processingState);
    isPlaying = ValueNotifier(_audioPlayer.playing);

    totalDuration = ValueNotifier(Duration.zero);
    currentDuration = ValueNotifier(_audioPlayer.position);

    nameController = TextEditingController(text: song.name);
    songAlbum = song.album;
    songArtist = song.artist;

    _audioPlayer.processingStateStream.listen((state) {
      playingState.value = state;
    });

    _audioPlayer.playingStream.listen((playing) {
      isPlaying.value = playing;
    });

    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) totalDuration.value = duration;
    });

    _audioPlayer.positionStream.listen((position) {
      currentDuration.value = position;
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

  void seekPosition(double position) {
    _audioPlayer.seek(Duration(milliseconds: position.toInt()));
  }

  Future<void> skipDuration({bool backwards = false}) async {
    (backwards)
        ? _audioPlayer.seek(_audioPlayer.position - Duration(seconds: 5))
        : _audioPlayer.seek(_audioPlayer.position + Duration(seconds: 5));
  }
}
