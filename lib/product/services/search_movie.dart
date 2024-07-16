import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/product/exceptions/exceptions.dart';

class SearchService {
  Future<List<Movie>> searchMovies(String movieName) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?query=$movieName&api_key=9951b759a9637d2c0390dba63a92e874"));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> results = json['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw MovieLoadException();
    }
  }
}
