import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/product/exceptions/exceptions.dart';
import 'package:popcorn/product/init/config/app_environment.dart';

class DiscoverMoviesServices {
  final String _pageParam = "&page=";
  final String _langKeyText = "&language=";

  Future<List<Movie>> fetchMovies(String langCode, {int pageNumber = 2}) async {
    final response = await http.get(Uri.parse(
        AppEnvironmentItems.discoverServiceUrl.value +
            AppEnvironmentItems.apiKey.value +
            _pageParam +
            pageNumber.toString() +
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
