import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SaveLinkPage extends StatelessWidget {
  final Song song;
  final Link? link;

  final bool isEditing;

  late TextEditingController titleEditingController;
  late TextEditingController urlEditingController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SaveLinkPage({
    required this.song,
    this.link,
    super.key,
    this.isEditing = false,
  }) {
    titleEditingController = TextEditingController();
    urlEditingController = TextEditingController();

    initFields();
  }

  void initFields() {
    if (link != null) {
      titleEditingController.text = link!.title;
      urlEditingController.text = link!.url;
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
                    "Save Link",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  CustomTextFormField(
                    "Title",
                    titleEditingController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill the field";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    "External link",
                    urlEditingController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill the field";
                      }
                      return null;
                    },
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
                          if (_formKey.currentState!.validate()) {
                            LinkController linkController = LinkController();

                            Link newLink = Link(
                              title: titleEditingController.text,
                              url: urlEditingController.text,
                              songId: song.id!,
                            );

                            if (!isEditing) {
                              try {
                                await linkController.create(newLink);
                              } catch (e) {
                                // linkController.delete(link); Add this delete right here AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Erro ao salvar link: $e'),
                                    ),
                                  );
                                }
                              }
                            } else {
                              // await linkController.update(link); ADD HERE TOOOOOOO!!!!!!!!!!
                            }

                            if (context.mounted) {
                              Navigator.of(context).pop(true);
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
