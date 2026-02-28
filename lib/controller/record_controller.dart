import 'package:guitar_song_improvement/data/local/database/dao/analysis_dao.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/data/model/dtos/record_with_analysis.dart';
import 'package:guitar_song_improvement/data/model/record.dart';
import 'package:guitar_song_improvement/data/local/database/dao/record_dao.dart';

// FInd a way to throw this class away. Just being used to follow other controllers standard implemention
class RecordController {
  RecordController();

  Future<int> create(Record record) async {
    RecordDao recordDao = RecordDao();
    return await recordDao.create(record);
  }

  Future<void> update(int oldRecordId, Record newRecord) async {
    RecordDao recordDao = RecordDao();
    await recordDao.update(oldRecordId, newRecord);
  }

  Future<List<RecordWithAnalysis>> recordsBySong(int songId) async {
    RecordDao recordDao = RecordDao();
    AnalysisDao analysisDao = AnalysisDao();

    final List<Record> records = await recordDao.recordsBySong(songId);

    final List<int> analysesIds = records
        .where((record) => record.analysisId != null)
        .map((record) => record.analysisId!)
        .toList();
    final List<Analysis> analyses = await analysisDao.analysesByIds(
      analysesIds,
    );

    List<RecordWithAnalysis> recordsWithAnalysis = [];
    for (Record record in records) {
      final Analysis? analysisForRecord = analyses
          .where((analysis) => record.analysisId == analysis.id)
          .firstOrNull;

      recordsWithAnalysis.add(
        RecordWithAnalysis(record: record, analysis: analysisForRecord),
      );
    }

    return recordsWithAnalysis;
  }

  Future<void> delete(int recordId) async {
    RecordDao recordDao = RecordDao();
    return await recordDao.delete(recordId);
  }
}
