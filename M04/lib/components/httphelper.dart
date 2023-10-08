import 'package:http/http.dart' as http;
import 'dart:io';

class HttpHelper {
  final String _urlKey = "?api_key=fd32ea8d9e92f032a1073ac1418330b9";
  final String _urlBase = "https://api.themoviedb.org/";
  Future<String> getMovie() async {
    var url = Uri.parse(_urlBase + '/3/movie/now_playing' + _urlKey);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    return result.statusCode.toString();
  }
}
