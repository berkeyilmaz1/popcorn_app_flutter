import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/product/exceptions/exceptions.dart';
import 'package:popcorn/product/init/config/app_environment.dart';

class SearchService {
  Future<List<Movie>> searchMovies(String movieName) async {
    final response = await http.get(Uri.parse(
        AppEnvironmentItems.searchServiceBaseUrl.value +
            movieName +
            AppEnvironmentItems.searchServiceApiKey.value));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> results = json['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw MovieLoadException();
    }
  }
}
