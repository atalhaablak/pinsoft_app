import 'dart:convert';
import 'package:http/http.dart' as http;

// API özellikleri alınarak gerekli sorgu yapıları hazırlandı.
class ApiService {
  static String key = "apikey=ae4ce192";
  static String api = "http://www.omdbapi.com/?${key}&";
  static String detail = "t=";
  static String search = "s=";
  static String imdbid = "i=";

  getMovieDetail(String movieName) async {
    final response = await http.get(Uri.parse(api + detail + movieName));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Hata");
    }
  }
  // orn -> http://www.omdbapi.com/?apikey=ae4ce192&t=Batman

  getMovieSearch(String searchMovie) async {
    final response = await http.get(Uri.parse(api + search + searchMovie));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Hata");
    }
  }
  // orn -> http://www.omdbapi.com/?apikey=ae4ce192&s=Batman

  getImdbDetail(String imdbID) async {
    final response = await http.get(Uri.parse(api + imdbid + imdbID));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Hata");
    }
  }
  // orn ->http://www.omdbapi.com/?apikey=ae4ce192&i=tt0372784
}
