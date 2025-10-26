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

                            await songController.create(
                              Song(
                                name: titleEditingController.text,
                                album: albumEditingController.text,
                                artist: artistEditingController.text,
                              ),
                            );

                            await albumController.create(
                              Album(name: albumEditingController.text),
                            );

                            await artistController.create(
                              Artist(name: artistEditingController.text),
                            );

                            Provider.of<MusicProvider>(
                              context,
                              listen: false,
                            ).getData();

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
