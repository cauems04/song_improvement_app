import 'package:guitar_song_improvement/data/model/record.dart';
import 'package:guitar_song_improvement/data/local/database/dao/record_dao.dart';

// FInd a way to throw this class away. Just being used to follow other controllers standard implemention
class RecordController {
  RecordController();

  Future<void> create(Record record) async {
    RecordDao recordDao = RecordDao();
    await recordDao.create(record);
  }

  Future<void> update(Record oldRecord, Record newRecord) async {
    RecordDao recordDao = RecordDao();
    await recordDao.update(oldRecord, newRecord);
  }

  Future<List<Record>> linksBySong(int songId) async {
    RecordDao recordDao = RecordDao();
    return await recordDao.recordsBySong(songId);
  }

  Future<void> delete(int recordId) async {
    RecordDao recordDao = RecordDao();
    return await recordDao.delete(recordId);
  }
}
