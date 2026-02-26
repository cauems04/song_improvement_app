import 'package:guitar_song_improvement/data/local/database/database_manager.dart';
import 'package:guitar_song_improvement/data/services/score_service.dart';

class Analysis {
  final int? id;
  final DateTime dateCreation;
  final int pitchScore;
  final int rhytmScore;
  final int dynamicsScore;
  final int techniqueScore;
  final int accuracyScore;
  final int songId;

  int get getFinalScore => ScoreService.calculateScore([
    pitchScore,
    rhytmScore,
    dynamicsScore,
    techniqueScore,
    accuracyScore,
  ]);

  const Analysis({
    required this.dateCreation,
    required this.pitchScore,
    required this.rhytmScore,
    required this.dynamicsScore,
    required this.techniqueScore,
    required this.accuracyScore,
    required this.songId,
    this.id,
  });

  Analysis.fromDbJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : id = json[DatabaseManager.analysisIdLabel],
      dateCreation = DateTime.parse(
        json[DatabaseManager.analysisDateCreationLabel].toString(),
      ),
      pitchScore = json[DatabaseManager.analysisPitchScoreLabel],
      rhytmScore = json[DatabaseManager.analysisRhytmScoreLabel],
      dynamicsScore = json[DatabaseManager.analysisDynamicsScoreLabel],
      techniqueScore = json[DatabaseManager.analysisTechniqueScoreLabel],
      accuracyScore = json[DatabaseManager.analysisAccuracyScoreLabel],
      songId = json[DatabaseManager.analysisSongLabel];

  Map<String, Object> toMap() {
    return {
      DatabaseManager.analysisDateCreationLabel: dateCreation,
      DatabaseManager.analysisPitchScoreLabel: pitchScore,
      DatabaseManager.analysisRhytmScoreLabel: rhytmScore,
      DatabaseManager.analysisDynamicsScoreLabel: dynamicsScore,
      DatabaseManager.analysisTechniqueScoreLabel: techniqueScore,
      DatabaseManager.analysisAccuracyScoreLabel: accuracyScore,
      DatabaseManager.analysisSongLabel: songId,
    };
  }
}
