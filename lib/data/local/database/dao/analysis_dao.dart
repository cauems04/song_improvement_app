import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/data/local/database/database_manager.dart';
import 'package:sqflite/sqflite.dart';

class AnalysisDao {
  AnalysisDao();

  Future<void> create(Analysis analysis) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.insert(DatabaseManager.analysisTableName, analysis.toMap());
  }

  Future<List<Analysis>> analysisBySong(int songId) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> analysisFound = await database.query(
      DatabaseManager.analysisTableName,
      where: "${DatabaseManager.analysisSongLabel} = ?",
      whereArgs: [songId],
    );

    if (analysisFound.isEmpty) return [];

    List<Analysis> analysis = analysisFound
        .map((analysis) => Analysis.fromDbJson(analysis))
        .toList();
    return analysis;
  }
}
