import 'package:guitar_song_improvement/model/album.dart';
import 'package:sqflite/sqflite.dart';
import 'package:guitar_song_improvement/repository/database_manager.dart';

class AlbumDao {
  AlbumDao();

  Future<void> create(Album album) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.insert(databaseManager.albumTableName, album.toMap());
  }

  Future<void> delete(Album album) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.delete(
      databaseManager.albumNameLabel,
      where:
          """
            ${databaseManager.albumNameLabel} = ?
          """,
      whereArgs: [album.name],
    );
  }

  Future<void> deleteAll() async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    print("All albums deleted");
    database.delete("album");
  }

  Future<Album> read(Album album) async {
    // This is gonna be implemented for the search feature
    // Review and apply it correctly later
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> result = await database.query(
      databaseManager.albumTableName,
      where:
          """
            ${databaseManager.albumNameLabel} = ?
          """,
      whereArgs: [album.name],
    );

    Album albumFound = Album.fromDbJson(result[0]);

    return albumFound;
  }

  Future<List<Album>> readAll() async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> data = await database.query(
      databaseManager.albumTableName,
    );

    List<Album> albums = [];
    for (Map<String, Object?> album in data) {
      albums.add(Album.fromDbJson(album));
    }

    return albums;
  }

  Future<bool> hasSongs(Album album) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    final List<Map<String, Object?>> result = await database.query(
      databaseManager.songTableName,
      columns: [
        'COUNT(*) as count',
      ], // Check how it works later!!!!!!!!!!!!!!!!!!!!!!!!!!!
      where: "${databaseManager.songAlbumLabel} = ?",
      whereArgs: [album.name],
    );

    int count = Sqflite.firstIntValue(result) ?? 0;

    return count > 0;
  }

  Future<bool> exists(Album album) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    final List<Map<String, Object?>> result = await database.rawQuery(
      "SELECT EXISTS(SELECT 1 FROM ${databaseManager.albumTableName} WHERE ${databaseManager.albumNameLabel} = ?) AS result;",
      [album.name],
    );

    return result.first["result"] == 1;
  }
}
