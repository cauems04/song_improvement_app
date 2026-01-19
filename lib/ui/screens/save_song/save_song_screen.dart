import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/model/music_provider.dart';
import 'package:guitar_song_improvement/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/save_song/widgets/song_custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SaveSongScreen extends StatelessWidget {
  final Song? song;

  final bool isEditing;

  late TextEditingController titleEditingController;
  late TextEditingController albumEditingController;
  late TextEditingController artistEditingController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SaveSongScreen({super.key, this.song, this.isEditing = false}) {
    titleEditingController = TextEditingController();
    albumEditingController = TextEditingController();
    artistEditingController = TextEditingController();

    initFields();
  }

  void initFields() {
    if (song != null) {
      titleEditingController.text = song!.name;
      albumEditingController.text = song!.album;
      artistEditingController.text = song!.artist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Icon(Icons.close, color: Colors.white),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 600,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 100,
              right: Spacing.xl,
              left: Spacing.xl,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Save Song",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SongCustomTextFormField(
                    "Title",
                    titleEditingController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill the field ${titleEditingController.text}";
                      }
                      return null;
                    },
                  ),
                  SongCustomTextFormField("Artist", artistEditingController),
                  SongCustomTextFormField("Album", albumEditingController),
                  SizedBox(
                    height: 40,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Save")],
                        ),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            SongController songController = SongController();
                            AlbumController albumController = AlbumController();
                            ArtistController artistController =
                                ArtistController();

                            Song newSong = Song(
                              name: titleEditingController.text.trim(),
                              album: albumEditingController.text
                                  .trim(), // Maybe in the future will need to pass Albums/Artists classes to songs, so it can have their covers for example, or to treat the values easily, for example, songController is fixing album and artist names (and it doesn't look cool being there).
                              artist: artistEditingController.text.trim(),
                            );
                            Album newAlbum = Album(
                              name: albumEditingController.text.trim(),
                            );
                            Artist newArtist = Artist(
                              name: artistEditingController.text.trim(),
                            );

                            if (!isEditing) {
                              try {
                                await artistController.create(newArtist);

                                await albumController.create(newAlbum);

                                await songController.create(newSong);
                              } catch (e) {
                                songController.delete(newSong);
                                artistController.delete(newArtist);
                                albumController.delete(newAlbum);

                                // Try catch logic - A song must be created only whether both artist and album were created
                                // If something happens when creating one of them, it'll catch an error and the song won't be created
                                // ALBUM and ARTIST can't be deleted if there's songs atached to them!!!!
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Erro ao salvar música: $e',
                                      ),
                                    ),
                                  );
                                }
                              }
                            } else {
                              if (!context.mounted) return;

                              await albumController.create(newAlbum);
                              await artistController.create(newArtist);

                              await Provider.of<SelectedSongProvider>(
                                context,
                                listen: false,
                              ).updateSong(newSong);

                              await albumController.delete(
                                Album(name: song!.album),
                              );
                              await artistController.delete(
                                Artist(name: song!.artist),
                              );
                            }

                            if (context.mounted) {
                              // Check this later and what wrong can happen for us to treat it
                              Provider.of<MusicProvider>(
                                context,
                                listen: false,
                              ).getData();

                              Navigator.of(context).pop();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveSong(Song song, Album album, Artist artist) async {}
}
