import 'package:flutter/services.dart';

class RecordChannel {
  final MethodChannel recordChannel = MethodChannel(
    "song_improvement/method/record",
  );

  Future<void> recordAudio() async {
    recordChannel.invokeMethod<void>("recordAudio");
  }
}
