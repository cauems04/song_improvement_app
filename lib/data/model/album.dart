import 'package:guitar_song_improvement/data/model/i_model.dart';

class Album implements IModel {
  final String _name;

  @override
  String get name => _name;

  const Album({required String name}) : _name = name;

  Album.fromDbJson(Map<String, Object?> json)
    : _name = json["title"].toString();

  @override
  Map<String, String> toMap() {
    return {"title": _name};
  }
}
