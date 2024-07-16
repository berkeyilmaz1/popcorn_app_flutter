import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Movie extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;
  final String? releaseDate;

  const Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return _$MovieFromJson(json);
  }
  @override
  List<Object?> get props => [id, title];
}
