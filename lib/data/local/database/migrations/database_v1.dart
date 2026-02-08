import 'package:guitar_song_improvement/data/local/database/database_manager.dart';
import 'package:guitar_song_improvement/data/local/database/migrations/i_migration.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseV1 implements IMigration {
  const DatabaseV1();

  @override
  Future<void> execute(Database db) async {
    await db.execute("""CREATE TABLE ${DatabaseManager.songTableName}(
                            ${DatabaseManager.songIdLabel} INTEGER PRIMARY KEY AUTOINCREMENT, 
                            ${DatabaseManager.songNameLabel} TEXT,
                            ${DatabaseManager.songScoreLabel} INTEGER DEFAULT 0,
                            ${DatabaseManager.songAlbumLabel} TEXT,
                            ${DatabaseManager.songArtistLabel} TEXT,

                            FOREIGN KEY(${DatabaseManager.songAlbumLabel}) REFERENCES ${DatabaseManager.albumTableName}(${DatabaseManager.albumNameLabel}),
                            FOREIGN KEY(${DatabaseManager.songArtistLabel}) REFERENCES ${DatabaseManager.artistTableName}(${DatabaseManager.artistNameLabel})
                            );""");

    await db.execute("""CREATE TABLE ${DatabaseManager.albumTableName}(
                            ${DatabaseManager.albumNameLabel} TEXT PRIMARY KEY UNIQUE NOT NULL 
                            );""");

    await db.execute("""CREATE TABLE ${DatabaseManager.artistTableName}(
                            ${DatabaseManager.artistNameLabel} TEXT PRIMARY KEY UNIQUE NOT NULL
                            );""");

    await db.execute("""CREATE TABLE ${DatabaseManager.linkTableName}(
                            ${DatabaseManager.linkIdLabel} INTEGER PRIMARY KEY AUTOINCREMENT,
                            ${DatabaseManager.linkNameLabel} TEXT NOT NULL,
                            ${DatabaseManager.linkUrlLabel} TEXT NOT NULL,
                            ${DatabaseManager.linkSongLabel} INTEGER NOT NULL,

                            FOREIGN KEY (${DatabaseManager.linkSongLabel}) REFERENCES ${DatabaseManager.songTableName}(${DatabaseManager.songIdLabel}) ON DELETE CASCADE
                            );""");

    await db.execute("""CREATE TABLE ${DatabaseManager.recordTableName}(
                            ${DatabaseManager.recordIdLabel} INTEGER PRIMARY KEY AUTOINCREMENT,
                            ${DatabaseManager.recordNameLabel} TEXT NOT NULL,
                            ${DatabaseManager.recordScoreLabel} INTEGER,
                            ${DatabaseManager.recordAudioFilePathLabel} TEXT NOT NULL,
                            ${DatabaseManager.recordDateCreationLabel} TEXT NOT NULL,
                            ${DatabaseManager.recordSongLabel} INTEGER NOT NULL,

                            FOREIGN KEY (${DatabaseManager.recordSongLabel}) REFERENCES ${DatabaseManager.songTableName}(${DatabaseManager.songIdLabel}) ON DELETE CASCADE
                            );""");
  }
}
