import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popcorn/feature/movie_card_info/model/image_model.dart';
import 'package:popcorn/product/exceptions/exceptions.dart';
import 'package:popcorn/product/init/config/app_environment.dart';

class ImageServices {
  final String _apiKeyText = "/images?api_key=";

  Future<List<ImageModel>> fetchImages(int id) async {
    final response = await http.get(Uri.parse(
        AppEnvironmentItems.imagesServiceUrl.value +
            id.toString() +
            _apiKeyText +
            AppEnvironmentItems.apiKey.value));

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
