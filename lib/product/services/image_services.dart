import 'dart:convert';

import 'package:Popcorn/feature/movie_card_info/model/image_model.dart';
import 'package:Popcorn/product/exceptions/exceptions.dart';
import 'package:Popcorn/product/init/config/app_environment.dart';
import 'package:http/http.dart' as http;

class ImageServices {
  final String _apiKeyText = "/images?api_key=";

  Future<List<ImageModel>> fetchImages(int id) async {
    final response = await http.get(Uri.parse(
        "${AppEnvironmentItems.imagesServiceUrl.value}$id$_apiKeyText${AppEnvironmentItems.apiKey.value}"));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> backdrops = json['backdrops'];
      return backdrops
          .map((imageJson) => ImageModel.fromJson(imageJson))
          .toList();
    } else {
      throw MovieLoadException();
    }
  }
}
