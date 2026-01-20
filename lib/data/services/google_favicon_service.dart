import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GoogleFaviconService {
  static const String _baseUrl = "www.google.com";

  static Future<Uint8List?> searchFavicon(Uri givenUrl) async {
    final Map<String, String> query = {
      "domain_url": givenUrl.toString(),
      "sz": "32",
    };

    final Uri url = Uri.https(_baseUrl, "s2/favicons", query);
    final http.Response response = await http.get(url);

    if (response.statusCode < 200 || response.statusCode >= 300) return null;

    return response.bodyBytes;
  }
}
