import 'package:flutter/material.dart';

class SongPage extends StatefulWidget {
  final String title;
  final String artist;
  final String album;
  const SongPage(this.title, this.artist, this.album, {super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 48, 54, 1),
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
        backgroundColor: Color.fromRGBO(47, 48, 54, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    widget.artist,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  widget.album,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _linkSection(),
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

class _linkSection extends StatefulWidget {
  const _linkSection({super.key});

  @override
  State<_linkSection> createState() => _linkSectionState();
}

class _linkSectionState extends State<_linkSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Support Links"),
        Container(width: 300, height: 2, color: Colors.white),
        Text("www.youtube.com/2rdchfidsbds78dh8i"),
        Icon(Icons.add),
      ],
    );
  }
}
