import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SaveSongPage extends StatelessWidget {
  final Song? song;

  SaveSongPage({super.key, this.song}) {
    titleEditingController = TextEditingController();
    albumEditingController = TextEditingController();
    artistEditingController = TextEditingController();

    initState();
  }

  late TextEditingController titleEditingController;
  late TextEditingController albumEditingController;
  late TextEditingController artistEditingController;

  void initState() {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Save Song",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  CustomTextFormField("Title", titleEditingController),
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
                        onTap: () {
                          //Implements song saving !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                          Navigator.pop(context);
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

  const CustomTextFormField(
    this.fieldName,
    this.textEditingController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        controller: textEditingController,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          floatingLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
