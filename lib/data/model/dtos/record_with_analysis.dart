import 'package:guitar_song_improvement/data/model/record.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';

class RecordWithAnalysis {
  final Record record;
  final Analysis? analysis;

  RecordWithAnalysis({required this.record, this.analysis});
}
