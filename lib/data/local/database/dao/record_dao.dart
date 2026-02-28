import 'package:guitar_song_improvement/data/local/database/database_manager.dart';
import 'package:guitar_song_improvement/data/model/record.dart';
import 'package:sqflite/sqflite.dart';

class RecordDao {
  RecordDao();

  Future<int> create(Record record) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    return await database.insert(
      DatabaseManager.recordTableName,
      record.toMap(),
    );
  }

  Future<void> update(int oldRecordId, Record newRecord) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.update(
      DatabaseManager.recordTableName,
      {
        DatabaseManager.recordNameLabel: newRecord.name,
        // DatabaseManager.recordScoreLabel: newRecord.score,
      },
      where: "${DatabaseManager.recordIdLabel} = ?",
      whereArgs: [oldRecordId],
    );
  }

  Future<List<Record>> recordsBySong(int songId) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;

    List<Map<String, Object?>> recordsFound = await database.query(
      DatabaseManager.recordTableName,
      where: "${DatabaseManager.recordSongLabel} = ?",
      whereArgs: [songId],
    );

    List<Record> records = recordsFound
        .map((recording) => Record.fromDbJson(recording))
        .toList();

    return records;

    // List<Analysis> analyses = await AnalysisDao().analysesByMultipleRecord(
    //   recordsFound
    //       .map((record) => record[DatabaseManager.recordIdLabel] as int)
    //       .toList(),
    // );

    // List<Record> records = [];
    // for (Map<String, Object?> record in recordsFound) {
    //   record["analysis"] = analyses.firstWhere(
    //     (analysis) =>
    //         analysis.recordId == record[DatabaseManager.recordIdLabel],
    //   );
    //   records.add(Record.fromDbJson(record));
    // }
  }

  Future<void> delete(int recordId) async {
    DatabaseManager databaseManager = DatabaseManager.databaseManager;
    Database database = await databaseManager.database;
    await database.delete(
      DatabaseManager.recordTableName,
      where: "${DatabaseManager.recordIdLabel} = ?",
      whereArgs: [recordId],
    );
  }
}
