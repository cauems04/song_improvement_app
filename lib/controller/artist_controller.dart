import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/local/database/dao/artist_dao.dart';

class ArtistController {
  const ArtistController();

  Future<List<Artist>> readAll() async {
    ArtistDao artistDao = ArtistDao();
    return await artistDao.readAll();
  }

  Future<void> create(Artist artist) async {
    final Artist artistFixed = Artist(
      name: (artist.name.isEmpty)
          ? "Unkown"
          : artist
                .name, // Create a function on the artist model to to this itself
    );

    ArtistDao artistDao = ArtistDao();

    bool artistExists = await artistDao.exists(artistFixed);

    if (artistExists) return;

    await artistDao.create(artistFixed);
  }

  Future<void> delete(Artist artist) async {
    final Artist artistFixed = Artist(
      name: (artist.name.isEmpty)
          ? "Unkown"
          : artist
                .name, // Create a function on the artist model to to this itself
    );

    ArtistDao artistDao = ArtistDao();

    if (await artistDao.exists(artistFixed)) {
      if (!(await artistDao.hasSongs(artistFixed))) {
        // Check where to use this function
        artistDao.delete(artistFixed);
      }
    }
  }
}
