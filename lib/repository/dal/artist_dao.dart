import 'package:guitar_song_improvement/model/artist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:guitar_song_improvement/repository/database_manager.dart';

class ArtistDao {
  ArtistDao();

  Future<void> create(Artist artist) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.insert(databaseManager.artistTableName, artist.toMap());
  }

  Future<void> delete(Artist artist) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.delete(
      databaseManager.artistTableName,
      where:
          """
            ${databaseManager.artistNameLabel} = ?
          """,
      whereArgs: [artist.name],
    );
  }

  Future<void> deleteAll() async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    print("All artists deleted");
    database.delete("artist");
  }

  Future<Artist> read(Artist artist) async {
    // This is gonna be implemented for the search feature
    // Review and apply it correctly later
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> result = await database.query(
      databaseManager.artistTableName,
      where:
          """
            ${databaseManager.artistNameLabel} = ?
          """,
      whereArgs: [artist.name],
    );

    Artist artistFound = Artist.fromDbJson(result[0]);

    return artistFound;
  }

  Future<List<Artist>> readAll() async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> data = await database.query(
      databaseManager.artistTableName,
    );

    List<Artist> artists = [];
    for (Map<String, Object?> album in data) {
      artists.add(Artist.fromDbJson(album));
    }

    return artists;
  }

  Future<bool> hasSongs(Artist artist) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    final List<Map<String, Object?>> result = await database.query(
      databaseManager.songTableName,
      columns: [
        'COUNT(*) as count',
      ], // Check how it works later!!!!!!!!!!!!!!!!!!!!!!!!!!!
      where: "${databaseManager.songArtistLabel} = ?",
      whereArgs: [artist.name],
    );

    int count = Sqflite.firstIntValue(result) ?? 0;

    return count > 0;
  }

  Future<bool> exists(Artist artist) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    final List<Map<String, Object?>> result = await database.rawQuery(
      "SELECT EXISTS(SELECT 1 FROM ${databaseManager.artistTableName} WHERE ${databaseManager.artistNameLabel} = ?) AS result;",
      [artist.name],
    );

    return result.first["result"] == 1;
  }
}
