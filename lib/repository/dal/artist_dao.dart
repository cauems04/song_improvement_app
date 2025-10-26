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
      databaseManager.artistNameLabel,
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
}
