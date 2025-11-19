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

  Future<void> update(Link oldLink, Link newLink) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.update(
      DatabaseManager.linkTableName,
      {
        DatabaseManager.linkNameLabel: newLink.title,
        DatabaseManager.linkUrlLabel: newLink.url.toString(),
      },
      where: "id = ?",
      whereArgs: [oldLink.id],
    );
  }

  Future<List<Link>> linksBySong(int songId) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> linksFound = await database.query(
      DatabaseManager.linkTableName,
      where: "${DatabaseManager.linkSongLabel} = ?",
      whereArgs: [songId],
    );

    if (linksFound.isEmpty) return [];

    List<Link> links = linksFound.map((link) => Link.fromDbJson(link)).toList();
    return links;
  }
}
