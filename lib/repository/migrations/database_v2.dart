// import 'package:guitar_song_improvement/repository/database_manager.dart';
// import 'package:guitar_song_improvement/repository/migrations/i_migration.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseV2 implements IMigration {
//   const DatabaseV2();

//   @override
//   void execute(Database db) async {
//     await db.execute("""CREATE TABLE ${DatabaseManager.songTableName}(
//                             ${DatabaseManager.songIdLabel} INTEGER PRIMARY KEY AUTOINCREMENT, 
//                             ${DatabaseManager.songNameLabel} TEXT, 
//                             ${DatabaseManager.songAlbumLabel} TEXT,
//                             ${DatabaseManager.songArtistLabel} TEXT,
//                             FOREIGN KEY(${DatabaseManager.songAlbumLabel}) REFERENCES ${DatabaseManager.albumTableName}(${DatabaseManager.albumNameLabel})
//                             FOREIGN KEY(${DatabaseManager.songArtistLabel}) REFERENCES ${DatabaseManager.artistTableName}(${DatabaseManager.artistNameLabel})
//                             )""");

//     await db.execute("""CREATE TABLE ${DatabaseManager.albumTableName}}(
//                             ${DatabaseManager.albumNameLabel} TEXT PRIMARY KEY UNIQUE NOT NULL 
//                             )""");

//     await db.execute("""CREATE TABLE ${DatabaseManager.artistTableName}}(
//                             ${DatabaseManager.artistNameLabel} TEXT PRIMARY KEY UNIQUE NOT NULL
//                             )""");
//   }
// }
