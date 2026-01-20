import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:sqflite/sqflite.dart';
import 'package:guitar_song_improvement/data/local/database/database_manager.dart';

class SongDao {
  SongDao();

  Future<void> create(Song song) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.insert(DatabaseManager.songTableName, song.toMap());
  }

  Future<void> update(Song oldSong, Song newSong) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.update(
      DatabaseManager.songTableName,
      {
        DatabaseManager.songNameLabel: newSong.name,
        DatabaseManager.songAlbumLabel: newSong.album,
        DatabaseManager.songArtistLabel: newSong.artist,
      },
      where: "id = ?",
      whereArgs: [oldSong.id],
    );
  }

  Future<void> delete(Song song) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.delete(
      DatabaseManager.songTableName,
      where:
          """
            ${DatabaseManager.songIdLabel} = ?
          """,
      whereArgs: [song.id],
    );
  }

  Future<Song> read(int songId) async {
    // This is gonna be implemented for the search feature
    // Review and apply it correctly later
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> result = await database.query(
      DatabaseManager.songTableName,
      where:
          """
            ${DatabaseManager.songIdLabel} = ?                              
          """,
      whereArgs: [songId],
    );

    Song songFound = Song.fromDbJson(result[0]);

    return songFound;
  }

  Future<List<Song>> readAll() async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> data = await database.query(
      DatabaseManager.songTableName,
    );

    List<Song> songs = [];
    for (Map<String, Object?> song in data) {
      songs.add(Song.fromDbJson(song));
    }

    return songs;
  }

  Future<void> deleteAll() async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    print("All deleted");
    database.delete("song");
  }

  Future<List<Song>> getSongsByAlbum(Album album) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> songsFound = await database.query(
      // Verify indexes creation on foreign keys to improve performance (fk for albums and artists)
      DatabaseManager.songTableName,
      where: "${DatabaseManager.songAlbumLabel} = ?",
      whereArgs: [album.name],
    );

    if (songsFound.isEmpty) {
      return [];
    }

    List<Song> songs = songsFound.map((song) => Song.fromDbJson(song)).toList();
    return songs;
  }

  Future<List<Song>> getSongsByArtist(Artist artist) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> songsFound = await database.query(
      // Verify indexes creation on foreign keys to improve performance (fk for albums and artists)
      DatabaseManager.songTableName,
      where: "${DatabaseManager.songArtistLabel} = ?",
      whereArgs: [artist.name],
    );

    if (songsFound.isEmpty) return [];

    List<Song> songs = songsFound.map((song) => Song.fromDbJson(song)).toList();
    return songs;
  }

  Future<bool> exists(Song song) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    final List<Map<String, Object?>> result = await database.rawQuery(
      "SELECT EXISTS(SELECT 1 FROM ${DatabaseManager.songTableName} WHERE ${DatabaseManager.songIdLabel} = ?) AS result;",
      [song.id],
    );

    return result.first["result"] == 1;
  }

  Future<void> updateScore(int songId, int newScore) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.update(
      DatabaseManager.songTableName,
      {DatabaseManager.songScoreLabel: newScore},
      where: "id = ?",
      whereArgs: [songId],
    );
  }
}
