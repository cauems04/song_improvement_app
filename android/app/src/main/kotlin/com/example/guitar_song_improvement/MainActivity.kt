package com.example.guitar_song_improvement

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()

// class MainActivity : FlutterActivity() {

//     private var audioRecorder: MediaRecorder? = null;

//     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//         super.configureFlutterEngine(flutterEngine);
        
//         MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "song_improvement/method/record")
//         .setMethodCallHandler(call, (result) {
            
//         });
//     }

//     private fun createRecorder(): MediaRecorder {
//         return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S){
//             MediaRecorder(contex); // Dunno how to get this context
//         }else MediaRecorder();
//     }

//     private fun start(outputFile: File) {
//         createRecorder().apply{
//             setAudioSource(MediaRecorder.AudioSource.MIC);
//             setOutputFormat(MediaRecorder.OutputFormat.MPEG_4);
//             setAudioEncoder(MediaRecorder.AudioEncoder.AAC);
//             setOutputFile(FileOutputStream(outputFile).fd);

//             prepare();
//         }
//     }
// }
