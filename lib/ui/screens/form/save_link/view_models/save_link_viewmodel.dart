import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/data/model/link.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_link/view_models/results/form_results.dart';

class SaveLinkViewmodel {
  final LinkController _linkController;

  late Link? link;
  late bool isEditing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController urlEditingController = TextEditingController();

  SaveLinkViewmodel(this._linkController);

  void init(Link? link, bool isEditing) {
    this.link = link;
    this.isEditing = isEditing;

    _initTextFields();
  }

  void _initTextFields() {
    if (link != null) {
      titleEditingController.text = link!.title;
      urlEditingController.text = link!.url.toString();
    }
  }

  String? validateField(String? text) {
    if (text == null || text.isEmpty) {
      return "Fill the field";
    }
    return null;
  }

  Future<FormResult> submitForm({required currentSongId}) async {
    if (!formKey.currentState!.validate()) {
      return AlertResult("Fill the fields correctly before submiting");
    }

    Link newLink = Link(
      title: titleEditingController.text.trim(),
      url: Uri.parse(urlEditingController.text.trim()),
      songId: currentSongId,
      // songId: Provider.of<SelectedSongProvider>(
      //   context,
      //   listen: false,
      // ).currentSong.id!,
    );

    if (!isEditing) {
      try {
        await _linkController.create(newLink);
      } catch (e) {
        // linkController.delete(link); Add this delete right here AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

        return ErrorResult("Error saving link. Try again");
      }
    } else {
      try {
        await _linkController.update(link!, newLink);
      } catch (e) {
        // linkController.delete(link); Add this delete right here AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

        return ErrorResult("Error updating link. Try again");
      }
    }

    return SuccessResult("Link saved succesfully!");
  }
}
