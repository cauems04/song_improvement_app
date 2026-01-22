import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_song/view_models/results/form_results.dart';

class SaveSongViewmodel {
  final SongController _songController;
  final AlbumController _albumController;
  final ArtistController _artistController;

  late Song? song;
  late bool isEditing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController albumEditingController = TextEditingController();
  final TextEditingController artistEditingController = TextEditingController();

  SaveSongViewmodel(
    this._songController,
    this._albumController,
    this._artistController,
  );

  void init(Song? song, bool isEditing) {
    this.song = song;
    this.isEditing = isEditing;

    _initTextFields();
  }

  void _initTextFields() {
    if (song != null) {
      titleEditingController.text = song!.name;
      albumEditingController.text = song!.album;
      artistEditingController.text = song!.artist;
    }
  }

  String? validateField(String? text) {
    if (text == null || text.isEmpty) {
      return "Fill the field";
    }
    return null;
  }

  Future<FormResult> submitForm() async {
    if (!formKey.currentState!.validate()) {
      return AlertResult("Fill the fields correctly before submiting");
    }

    Song newSong = Song(
      name: titleEditingController.text.trim(),
      album: albumEditingController.text
          .trim(), // Maybe in the future will need to pass Albums/Artists classes to songs, so it can have their covers for example, or to treat the values easily, for example, songController is fixing album and artist names (and it doesn't look cool being there).
      // Yeah, it's a better idea to use the classes instead of strings here, change it in the Song class later
      artist: artistEditingController.text.trim(),
    );
    Album newAlbum = Album(name: albumEditingController.text.trim());
    Artist newArtist = Artist(name: artistEditingController.text.trim());

    if (!isEditing) {
      // Check all this logic again
      try {
        await _artistController.create(newArtist);

        await _albumController.create(newAlbum);

        await _songController.create(newSong);
      } catch (e) {
        _songController.delete(newSong);
        _artistController.delete(newArtist);
        _albumController.delete(newAlbum);

        // Try catch logic - A song must be created only whether both artist and album were created
        // If something happens when creating one of them, it'll catch an error and the song won't be created
        // ALBUM and ARTIST can't be deleted if there's songs atached to them!!!!

        return ErrorResult("Error saving song. Try again");
      }
    } else {
      try {
        await _albumController.create(newAlbum);
        await _artistController.create(newArtist);
        await _songController.update(song!, newSong);

        // await Provider.of<SelectedSongProvider>(
        //   context,
        //   listen: false,
        // ).updateSong(newSong);

        await _albumController.delete(Album(name: song!.album));
        await _artistController.delete(Artist(name: song!.artist));

        return UpdatedResult("Song updated succesfully!");
      } catch (e) {
        return ErrorResult("Error updating song. Try again");
      }
    }

    return SuccessResult("Song saved succesfully!");
  }
}
