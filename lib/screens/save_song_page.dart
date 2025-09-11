import 'package:flutter/material.dart';

class SaveSongPage extends StatelessWidget {
  const SaveSongPage({super.key});

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
      body: Center(
        child: SizedBox(
          height: 600,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100, right: 26, left: 26),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Save Song",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextFormField("Title"),
                  CustomTextFormField("Artist"),
                  CustomTextFormField("Album"),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(206, 160, 221, 1),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 200,
                        height: 34,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Save")],
                        ),
                      ),
                      onTap: () {},
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
