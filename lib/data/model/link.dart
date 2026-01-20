import 'package:guitar_song_improvement/data/local/database/database_manager.dart';

class Link {
  final int? id;
  final String title;
  final Uri url;
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
      url = Uri.parse(json[DatabaseManager.linkUrlLabel].toString()),
      songId = json[DatabaseManager.linkSongLabel];

  Map<String, Object> toMap() {
    return {
      DatabaseManager.linkNameLabel: title,
      DatabaseManager.linkUrlLabel: url.toString(),
      DatabaseManager.linkSongLabel: songId,
    };
  }
}
