import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popcorn/feature/movie_card_info/model/detail_model.dart';
import 'package:popcorn/product/exceptions/exceptions.dart';
import 'package:popcorn/product/init/config/app_environment.dart';

class GetDetailsService {
  Future<List<DetailModel>> getCategoryNames({int? id = 502356}) async {
    final response = await http.get(Uri.parse(
        AppEnvironmentItems.getDetailBaseUrl.value +
            id.toString() +
            AppEnvironmentItems.getDetailApikey.value));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> genres = json['genres'];
      return genres
          .map((imageJson) => DetailModel.fromJson(imageJson))
          .toList();
    } else {
      throw MovieLoadException();
    }
  }
}
