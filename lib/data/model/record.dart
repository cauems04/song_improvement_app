import 'package:guitar_song_improvement/data/local/database/database_manager.dart';

class Record {
  final int? id;
  final String name;
  int? score;
  final String audioPath;
  final DateTime dateCreation;
  final int songId;

  String get formatedDate =>
      "${dateCreation.year}/${dateCreation.month.toString().padLeft(2, '0')}/${dateCreation.day.toString().padLeft(2, '0')}";

  Record({
    required this.name,
    required this.audioPath,
    required this.dateCreation,
    required this.songId,
    this.id,
    this.score,
  });

  Record.fromDbJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : id = json[DatabaseManager.recordIdLabel],
      name = json[DatabaseManager.recordNameLabel].toString(),
      score = json[DatabaseManager.recordScoreLabel],
      audioPath = json[DatabaseManager.recordAudioFilePathLabel].toString(),
      dateCreation = DateTime.parse(
        json[DatabaseManager.recordDateCreationLabel],
      ),
      songId = json[DatabaseManager.recordSongLabel];

  Map<String, Object> toMap() {
    return {
      DatabaseManager.recordNameLabel: name,
      DatabaseManager.recordAudioFilePathLabel: audioPath,
      DatabaseManager.recordDateCreationLabel: dateCreation.toString(),
      DatabaseManager.recordSongLabel: songId,
    };
  }
}
