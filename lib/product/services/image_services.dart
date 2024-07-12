import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/feature/movie_card_info/image_model.dart';
import 'package:movie_app/product/init/config/app_environment.dart';

class ImageServices {
  Future<List<ImageModel>> fetchImages(int id) async {
    final response = await http.get(Uri.parse(
        "http://api.themoviedb.org/3/movie/$id/images?api_key=${AppEnvironmentItems.apiKey.value}"));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> backdrops = json['backdrops'];
      return backdrops
          .map((imageJson) => ImageModel.fromJson(imageJson))
          .toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
