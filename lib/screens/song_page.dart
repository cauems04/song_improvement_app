import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SongPage extends StatefulWidget {
  final Song song;
  const SongPage(this.song, {super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.close, color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.song.name,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    widget.song.artist,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text(
                  widget.song.album,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 200,
                  ), // TESTESTESTESTESTESTESTESTESTE
                  child: _LinkSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String fieldName;
  const CustomTextFormField(this.fieldName, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: TextStyle(color: Colors.white60, fontSize: 16),
      ),
    );
  }
}

class _LinkSection extends StatefulWidget {
  const _LinkSection();

  @override
  State<_LinkSection> createState() => _linkSectionState();
}

class _linkSectionState extends State<_LinkSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Support Links", style: Theme.of(context).textTheme.titleLarge),
        Padding(
          padding: const EdgeInsets.only(top: Spacing.xs, bottom: Spacing.xs),
          child: Container(width: 300, height: 2, color: Colors.white),
        ),
        Text(
          "www.youtube.com/2rdchfidsbds78dh8i",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Icon(Icons.add),
      ],
    );
  }
}
