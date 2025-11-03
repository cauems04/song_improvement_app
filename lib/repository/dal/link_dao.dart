import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/repository/database_manager.dart';
import 'package:sqflite/sqflite.dart';

class LinkDao {
  LinkDao();

  Future<void> create(Link link) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.insert(DatabaseManager.linkTableName, link.toMap());
  }

  Future<List<Link>> linksBySong(int song_id) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> linksFound = await database.query(
      DatabaseManager.linkTableName,
      where: "${DatabaseManager.linkSongLabel} = ?",
      whereArgs: [song_id],
    );

    if (linksFound.isEmpty) return [];

    List<Link> links = linksFound.map((link) => Link.fromDbJson(link)).toList();
    return links;
  }
}
