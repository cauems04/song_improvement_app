import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/model/music_provider.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:provider/provider.dart';

class SaveSongPage extends StatelessWidget {
  final Song? song;

  late TextEditingController titleEditingController;
  late TextEditingController albumEditingController;
  late TextEditingController artistEditingController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SaveSongPage({super.key, this.song}) {
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
                  CustomTextFormField(
                    "Title",
                    titleEditingController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill the field ${titleEditingController.text}";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField("Artist", artistEditingController),
                  CustomTextFormField("Album", albumEditingController),
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
                            Songcontroller songController = Songcontroller();
                            Albumcontroller albumController = Albumcontroller();
                            ArtistController artistController =
                                ArtistController();

                            Song song = Song(
                              name: titleEditingController.text.trim(),
                              album: albumEditingController.text
                                  .trim(), // Maybe in the future will need to pass Albums/Artists classes to songs, so it can have their covers for example, or to treat the values easily, for example, songController is fixing album and artist names (and it doesn't look cool being there).
                              artist: artistEditingController.text.trim(),
                            );
                            Album album = Album(
                              name: albumEditingController.text.trim(),
                            );
                            Artist artist = Artist(
                              name: artistEditingController.text.trim(),
                            );

                            try {
                              await artistController.create(artist);

                              await albumController.create(album);

                              await songController.create(song);

                              Provider.of<MusicProvider>(
                                context,
                                listen: false,
                              ).getData();
                            } catch (e) {
                              artistController.delete(artist);
                              albumController.delete(album);
                              songController.delete(song);

                              // Try catch logic - A song must be created only whether both artist and album were created
                              // If something happens when creating one of them, it'll catch an error and the song won't be created
                              // ALBUM and ARTIST can't be deleted if there's songs atached to them!!!!
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao salvar música: $e'),
                                ),
                              );
                            }

                            print(
                              "Song created - $titleEditingController.text - $albumEditingController.text - $artistEditingController.text",
                            );

                            Navigator.of(context).pop(1);
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
}

class CustomTextFormField extends StatelessWidget {
  final String fieldName;
  final TextEditingController textEditingController;

  final String? Function(String?)? validation;

  const CustomTextFormField(
    this.fieldName,
    this.textEditingController, {
    super.key,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: textEditingController,
        validator: validation,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          floatingLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          errorStyle: TextStyle(color: Theme.of(context).colorScheme.onError),
          helperText: "",
        ),
      ),
    );
  }
}
