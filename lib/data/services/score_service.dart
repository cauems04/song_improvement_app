class ScoreService {
  static int calculateScore(List<int> scores) {
    final sum = scores.fold(0, (total, score) => total + score + 1);
    final range = scores.length * 4;

    return (sum - scores.length) * 100 ~/ range;
  }
}
