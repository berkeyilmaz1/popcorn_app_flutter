import 'package:Popcorn/feature/home/model/popular_movies_model.dart';
import 'package:Popcorn/feature/movie_card_info/movie_card_info.dart';
import 'package:Popcorn/product/constants/text_styles.dart';
import 'package:Popcorn/product/extensions/extensions.dart';
import 'package:Popcorn/product/init/config/app_environment.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  const MovieCard(
      {super.key,
      required this.movie,
      this.indexNumber,
      this.isTopRated = false});
  final Movie movie;
  final int? indexNumber;
  final bool isTopRated;
  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPadding.halfAll(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ///125 is the 4 times smaller the images size [500].
              _isTopRatedLogic(),
              _moviePosters(),
              _topRatedNumbers()
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _isTopRatedLogic() {
    return ((widget.isTopRated)

        ///175 width for the text can me moved left
        ? const SizedBox(
            width: 175,
          )
        : const SizedBox(
            width: 0,
            height: 0,
          ));
  }

  GestureDetector _moviePosters() {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MovieCardInfo(
                movie: widget.movie,
              ))),
      child: Image.network(
        AppEnvironmentItems.imageBaseUrl.value + (widget.movie.posterPath),
        scale: 4.5,
      ),
    );
  }

  Positioned _topRatedNumbers() {
    return Positioned(
        left: 2,
        child: (widget.indexNumber != null)
            ? Text((widget.indexNumber! + 1).toString(),
                style: ProjectTextStyles.instance.topRatedTextStyle)
            : const SizedBox.shrink());
  }
}
