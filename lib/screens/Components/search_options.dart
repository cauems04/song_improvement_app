import 'package:flutter/material.dart';

class SearchOptions extends StatefulWidget {
  const SearchOptions({super.key});

  @override
  State<SearchOptions> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchOptions> {
  bool onlineSearch = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            setState(() {
              onlineSearch = true;
            });
          },
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    "Online Search",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 150,
                height: (onlineSearch == true) ? 10 : 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (onlineSearch == true)
                      ? Colors.blueGrey
                      : Colors.black26,
                ),
              ),
            ],
          ),
        ),

        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            setState(() {
              onlineSearch = false;
            });
          },
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    "Saved Songs",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 150,
                height: (onlineSearch == false) ? 10 : 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (onlineSearch == false)
                      ? Colors.blueGrey
                      : Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
