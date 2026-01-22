import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_song/view_models/results/form_results.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_song/view_models/save_song_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_song/widgets/song_custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SaveSongScreen extends StatelessWidget {
  final SaveSongViewmodel saveSongVM = SaveSongViewmodel(
    SongController(),
    AlbumController(),
    ArtistController(),
  );

  SaveSongScreen({super.key, Song? song, bool isEditing = false}) {
    saveSongVM.init(song, isEditing);
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
              key: saveSongVM.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Save Song",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SongCustomTextFormField(
                    "Title",
                    saveSongVM.titleEditingController,
                    validation: (value) {
                      return saveSongVM.validateField(value);
                    },
                  ),
                  SongCustomTextFormField(
                    "Artist",
                    saveSongVM.artistEditingController,
                  ),
                  SongCustomTextFormField(
                    "Album",
                    saveSongVM.albumEditingController,
                  ),
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
                          final FormResult result = await saveSongVM
                              .submitForm();

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result.message)),
                          );

                          if (result is SuccessResult) {
                            Provider.of<MusicProvider>(
                              context,
                              listen: false,
                            ).getData();
                            Navigator.of(context).pop();
                          } else if (result is UpdatedResult) {
                            Provider.of<SelectedSongProvider>(
                              context,
                              listen: false,
                            ).updateSong();
                            Navigator.of(context).pop();
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
