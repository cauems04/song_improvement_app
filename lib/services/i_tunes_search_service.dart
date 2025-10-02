import 'dart:convert';

import 'package:http/http.dart' as http;

class ITunesSearchService {
  static const String _baseUrl = "itunes.apple.com";

  static Future<List<Map<String, dynamic>>> search(String parameter) async {
    // Tentar mudar de dynamic pra object para melhor performance
    Map<String, String> query = {
      "term": parameter,
      "media": "music",
      "entity": "musicTrack",
      "limit": "15",
    };

    Uri uri = Uri.https(_baseUrl, "search", query);

    final http.Response response = await http.get(uri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Failed to load data");
    }

    final List<dynamic> output =
        jsonDecode(response.body)["results"] as List<dynamic>;

    return output.map((e) => e as Map<String, dynamic>).toList();
  }
}

// void main() async {
//   final data = await ITunesSearchService.search("alice in chains");

//   print(data);
// }
