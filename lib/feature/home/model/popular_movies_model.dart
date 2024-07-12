import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_movies_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Movie extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  final String posterPath;
  final double voteAverage;
  final String? releaseDate;
 

  const Movie(
      { 
      required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      releaseDate: json['release_date'],
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
     
    );
  }
  @override
  List<Object?> get props => [id, title];
}
