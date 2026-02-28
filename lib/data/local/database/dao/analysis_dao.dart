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

  // Future<Analysis?> analysisBySingleRecord(int recordId) async {
  //   DatabaseManager databaseManager = DatabaseManager.databaseManager;
  //   Database database = await databaseManager.database;

  //   List<Map<String, Object?>> analysisFound = await database.query(
  //     DatabaseManager.analysisTableName,
  //     where: "${DatabaseManager.analysisRecordLabel} = ?",
  //     whereArgs: [recordId],);

  //   if (analysisFound.isEmpty) return null;

  //   Analysis analysis = Analysis.fromDbJson(analysisFound.first);
  //   return analysis;
  // }

  Future<List<Analysis>> analysesByIds(List<int> analysesIds) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    final String analysesIdsPlaceholders = List.filled(
      analysesIds.length,
      "?",
    ).join(",");

    List<Map<String, Object?>> analysisFound = await database.query(
      DatabaseManager.analysisTableName,
      where: "${DatabaseManager.analysisIdLabel} IN ($analysesIdsPlaceholders)",
      whereArgs: analysesIds,
    );

    // Put indexes on the database to search faster on big tables - search later
    // chunkSize = 900; search later
    return analysisFound
        .map((analysis) => Analysis.fromDbJson(analysis))
        .toList();
  }
}
