import 'package:guitar_song_improvement/data/local/database/database_manager.dart';

class Record {
  final int? id;
  final String name;
  final String audioPath;
  final String dateCreation;
  final int songId;

  const Record({
    required this.name,
    required this.audioPath,
    required this.dateCreation,
    required this.songId,
    this.id,
  });

  Record.fromDbJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : id = json[DatabaseManager.recordIdLabel],
      name = json[DatabaseManager.recordNameLabel].toString(),
      audioPath = json[DatabaseManager.recordAudioPathLabel].toString(),
      dateCreation = json[DatabaseManager.recordDateCreationLabel].toString(),
      songId = json[DatabaseManager.recordSongLabel];

  Map<String, Object> toMap() {
    return {
      DatabaseManager.recordNameLabel: name,
      DatabaseManager.recordAudioPathLabel: audioPath,
      DatabaseManager.recordDateCreationLabel: dateCreation,
      DatabaseManager.recordSongLabel: songId,
    };
  }
}
