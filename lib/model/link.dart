import 'package:guitar_song_improvement/repository/database_manager.dart';

class Link {
  final int? id;
  final String title;
  final String url;
  final int songId;

  const Link({
    required this.title,
    required this.url,
    required this.songId,
    this.id,
  });

  Link.fromDbJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : id = json[DatabaseManager.linkIdLabel],
      title = json[DatabaseManager.linkNameLabel].toString(),
      url = json[DatabaseManager.linkUrlLabel].toString(),
      songId = json[DatabaseManager.linkSongLabel];

  Map<String, Object> toMap() {
    return {
      DatabaseManager.linkNameLabel: title,
      DatabaseManager.linkUrlLabel: url,
      DatabaseManager.linkSongLabel: songId,
    };
  }
}
