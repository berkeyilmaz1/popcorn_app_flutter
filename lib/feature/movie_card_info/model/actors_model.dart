import 'package:json_annotation/json_annotation.dart';

part 'actors_model.g.dart';

@JsonSerializable(createToJson: false)
class ActorModel {
  final String? name;
  final String? character;
  final String? profilePath;

  const ActorModel({
    this.name,
    this.character,
    this.profilePath,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return _$ActorModelFromJson(json);
  }

 
}
