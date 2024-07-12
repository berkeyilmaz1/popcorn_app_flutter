import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/feature/home/model/popular_movies_model.dart';
import 'package:movie_app/product/init/config/app_environment.dart';

class DiscoverMoviesServices {
  Future<List<Movie>> fetchMovies({int pageNumber = 2}) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/discover/movie?api_key=${AppEnvironmentItems.apiKey.value}&page=$pageNumber"));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> results = json['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
