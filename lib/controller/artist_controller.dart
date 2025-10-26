import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/repository/dal/artist_dao.dart';

class ArtistController {
  const ArtistController();

  Future<List<Artist>> readAll() async {
    ArtistDao artistDao = ArtistDao();
    return await artistDao.readAll();
  }

  Future<void> create(Artist artist) async {
    final Artist artistFixed = Artist(
      name: (artist.name.isEmpty) ? "Unkown" : artist.name,
    );

    ArtistDao artistDao = ArtistDao();
    await artistDao.create(artistFixed);
  }
}
