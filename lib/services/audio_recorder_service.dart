// import 'dart:typed_data';

// import 'package:record/record.dart';

// class AudioRecorderService {
//   final AudioRecorder audioRecorder = AudioRecorder();

//   Future<void> start() async {
//     try {
//       final Future<Stream<Uint8List>> stream = audioRecorder.startStream(
//         const RecordConfig(),
//       );
//     } catch (e) {
//       print(
//         "Issue initializing audio recordung",
//       ); // Implement try / catch here later
//     }
//   }

//   Future<void> pauseOrResume() async {
//     if (await audioRecorder.isRecording()) {
//       audioRecorder.pause();
//     } else if (await audioRecorder.isPaused()) {
//       audioRecorder.resume();
//     }
//   }

//   Future<void> stop() async {
//     await audioRecorder.stop();
//   }

//   Future<void> cancel() async {
//     await audioRecorder.cancel();
//   }
// }
