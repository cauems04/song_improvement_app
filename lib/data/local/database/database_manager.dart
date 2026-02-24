import 'package:guitar_song_improvement/data/local/database/migrations/database_v1.dart';
import 'package:guitar_song_improvement/data/local/database/migrations/i_migration.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  final int dbVersion = 1;
  Map<int, IMigration> migrations = {1: DatabaseV1()};

  static final DatabaseManager databaseManager = DatabaseManager._constructor();

  static Database? _db;

  Future<Database> get database async {
    _db ??= await _getDabatase();

    return _db!;
  }

  DatabaseManager._constructor();

  // Song
  static const String songTableName = "song";
  static const String songIdLabel = "id";
  static const String songNameLabel = "title";
  static const String songScoreLabel = "score";
  static const String songTimesPlayedLabel = "times_played";
  static const String songAlbumLabel = "album_title";
  static const String songArtistLabel = "artist_name";
  // put last playied date

  // Album
  static const String albumTableName = "album";
  static const String albumNameLabel = "title";

  // Artist
  static const String artistTableName = "artist";
  static const String artistNameLabel = "name";

  // External link
  static const String linkTableName = "link";
  static const String linkIdLabel = "id";
  static const String linkNameLabel = "title";
  static const String linkUrlLabel = "url";
  static const String linkSongLabel = "song_id";

  // Records
  static const String recordTableName = "record";
  static const String recordIdLabel = "id";
  static const String recordNameLabel = "name";
  static const String recordScoreLabel = "score";
  static const String recordAudioFilePathLabel = "audio_file_path";
  static const String recordDateCreationLabel = "date_creation";
  static const String recordSongLabel = "song_id";

  static const String analysisTableName = "analysis";
  static const String analysisIdLabel = "id";
  static const String analysisPitchScoreLabel = "pitch_score";
  static const String analysisRhytmScoreLabel = "rhytm_score";
  static const String analysisDynamicsScoreLabel = "dynamics_score";
  static const String analysisTechniqueScoreLabel = "technique_score";
  static const String analysisAccuracyScoreLabel = "accuracy_score";
  static const String analysisDateCreationLabel = "date_creation";
  static const String analysisSongLabel = "song_id";

  void _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> _getDabatase() async {
    final String databasePath = join(
      await getDatabasesPath(),
      "song_improvement.db",
    );

    final Database database = await openDatabase(
      databasePath,
      version: dbVersion,
      onConfigure: (db) => _onConfigure(db),
      onCreate: (db, version) async {
        for (int i = 1; i <= migrations.length; i++) {
          migrations[i]!.execute(db);
        }
      },
      // onUpgrade: (db, oldVersion, newVersion) {},
    );

    return database;
  }

  // void printDbPath() async {
  //   String path = await getDatabasesPath();
  //   print("Database path: " + path);
  // }
}
