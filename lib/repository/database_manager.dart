import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static Database? _db;

  static final DatabaseManager databaseManager = DatabaseManager._constructor();

  Future<Database> get database async {
    _db ??= await _getDabatase();

    return _db!;
  }

  final String songTableName = "song";
  final String songIdLabel = "id";
  final String songNameLabel = "title";
  final String songAlbumLabel = "album_title";
  final String songArtistLabel = "artist_name";

  final String albumTableName = "album";
  final String albumNameLabel = "title";

  final String artistTableName = "artist";
  final String artistNameLabel = "name";

  DatabaseManager._constructor();

  Future<Database> _getDabatase() async {
    final String databasePath = join(
      await getDatabasesPath(),
      "song_improvement.db",
    );

    final Database database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""CREATE TABLE $songTableName(
                            $songIdLabel INTEGER PRIMARY KEY AUTOINCREMENT, 
                            $songNameLabel TEXT, 
                            $songAlbumLabel TEXT,
                            $songArtistLabel TEXT,
                            FOREIGN KEY($songAlbumLabel) REFERENCES $albumTableName($albumNameLabel)
                            FOREIGN KEY($songArtistLabel) REFERENCES $artistTableName($artistNameLabel)
                            )""");

        await db.execute("""CREATE TABLE $albumTableName(
                            $albumNameLabel TEXT PRIMARY KEY UNIQUE NOT NULL 
                            )""");

        await db.execute("""CREATE TABLE $artistTableName(
                            $artistNameLabel TEXT PRIMARY KEY UNIQUE NOT NULL
                            )""");
      },
    );

    return database;
  }

  // void printDbPath() async {
  //   String path = await getDatabasesPath();
  //   print("Database path: " + path);
  // }
}
