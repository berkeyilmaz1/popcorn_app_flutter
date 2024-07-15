import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/product/exceptions/exceptions.dart';
import 'package:popcorn/product/init/config/app_environment.dart';

class MoviesServices {
  final String _apiKeyText = "?api_key=";
  final String _langKeyText = "&language=";

  Future<List<Movie>> fetchMovies(String pathName, String langCode) async {
    final response = await http.get(Uri.parse(
        AppEnvironmentItems.moviesServiceUrl.value +
            pathName +
            _apiKeyText +
            AppEnvironmentItems.apiKey.value +
            _langKeyText +
            langCode));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> results = json['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw MovieLoadException();
    }
  }
}
