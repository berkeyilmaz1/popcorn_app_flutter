import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/model/popular_movies_model.dart';
import 'package:movie_app/feature/movie_card_info/image_model.dart';
import 'package:movie_app/product/constants/strings.dart';
import 'package:movie_app/product/constants/text_styles.dart';
import 'package:movie_app/product/extensions/extensions.dart';
import 'package:movie_app/product/services/image_services.dart';

class MovieCardInfo extends StatefulWidget {
  const MovieCardInfo({super.key, required this.movie});
  final Movie movie;
  @override
  State<MovieCardInfo> createState() => _MovieCardInfoState();
}

class _MovieCardInfoState extends State<MovieCardInfo> {
  late Future<List<ImageModel>>? images;
  final ImageServices _imageService = ImageServices();

  @override
  void initState() {
    super.initState();
    images = _imageService.fetchImages(widget.movie.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movie.title ?? " ",
              style: ProjectTextStyles.instance.movieInfoHeader),
        ),
        body: Center(
          child: Padding(
            padding: const ProjectPadding.all(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _movieImages(),
                const Divider(),
                Text(
                  widget.movie.title ?? "",
                  style: ProjectTextStyles.instance.movieInfoTitle,
                ),
                Text(
                  widget.movie.releaseDate ?? "",
                  style: ProjectTextStyles.instance.movieInfoYear,
                ),
                const Spacer(),
                Text(
                  widget.movie.overview ?? "",
                  style: ProjectTextStyles.instance.movieInfoDesc,
                ),
                const Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.star_rate_rounded,
                        ),
                        Text(
                          widget.movie.voteAverage.toStringAsFixed(2),
                          style: ProjectTextStyles.instance.movieInfoDesc,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const ProjectPadding.all(),
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          child:
                              Text(StringConstants.instance.addTheWatchList))),
                )
              ],
            ),
          ),
        ));
  }

  FutureBuilder<List<ImageModel>> _movieImages() {
    return FutureBuilder<List<ImageModel>>(
      future: images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (snapshot.data?.length)! ~/ 2,
              itemBuilder: (context, index) {
                ImageModel image = snapshot.data![index];
                return Padding(
                  padding: const ProjectPadding.halfAll(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.network(
                      ImageModel().pathToImage(image.filePath ?? "").toString(),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
