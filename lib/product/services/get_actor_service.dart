import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popcorn/feature/movie_card_info/model/actors_model.dart';
import 'package:popcorn/product/exceptions/exceptions.dart';
import 'package:popcorn/product/init/config/app_environment.dart';

class GetActorService {
  Future<List<ActorModel>> getActors(int? id) async {
    final response = await http.get(Uri.parse(
        (AppEnvironmentItems.getActorBaseUrl.value +
            id.toString() +
            AppEnvironmentItems.getActorApiKey.value)));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> cast = json['cast'];
      return cast.map((imageJson) => ActorModel.fromJson(imageJson)).toList();
    } else {
      throw MovieLoadException();
    }
  }
}
