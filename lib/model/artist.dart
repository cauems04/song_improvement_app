import 'package:guitar_song_improvement/model/i_model.dart';

class Artist implements IModel {
  final String _name;

  @override
  String get name => _name;

  const Artist({required String name}) : _name = name;

  Artist.fromDbJson(Map<String, Object?> json)
    : _name = json["name"].toString();

  @override
  Map<String, String> toMap() {
    return {"name": _name};
  }
}
