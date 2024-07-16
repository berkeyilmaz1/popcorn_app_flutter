import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/feature/movie_card_info/model/actors_model.dart';
import 'package:popcorn/feature/movie_card_info/model/detail_model.dart';
import 'package:popcorn/feature/movie_card_info/model/image_model.dart';
import 'package:popcorn/feature/watchlist/viewmodel/watchlist_viewmodel.dart';
import 'package:popcorn/product/constants/text_styles.dart';
import 'package:popcorn/product/extensions/extensions.dart';
import 'package:popcorn/product/init/config/app_environment.dart';
import 'package:popcorn/product/localization/locale_keys.g.dart';
import 'package:popcorn/product/services/get_actor_service.dart';
import 'package:popcorn/product/services/get_details_service.dart';
import 'package:popcorn/product/services/image_services.dart';
import 'package:provider/provider.dart';

class MovieCardInfo extends StatefulWidget {
  const MovieCardInfo({super.key, required this.movie});
  final Movie movie;
  @override
  State<MovieCardInfo> createState() => _MovieCardInfoState();
}

class _MovieCardInfoState extends State<MovieCardInfo> {
  late Future<List<ImageModel>>? images;
  final ImageServices _imageService = ImageServices();
  late Future<List<DetailModel>>? categorys;
  final GetDetailsService detailService = GetDetailsService();
  late Future<List<ActorModel>>? actors;
  final GetActorService _actorService = GetActorService();

  @override
  void initState() {
    super.initState();
    images = _imageService.fetchImages(widget.movie.id ?? 0);
    categorys = detailService.getCategoryNames(
      id: widget.movie.id,
    );
    actors = _actorService.getActors(
      widget.movie.id,
    );
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
                _movieTitle(),
                _categorys(),
                _watchTrailerButton(),
                _actors(),
                _movieOverview(),
                const Spacer(),
                _addTheWatchlistButton()
              ],
            ),
          ),
        ));
  }

  SizedBox _categorys() {
    return SizedBox(
      height: 40,
      child: FutureBuilder<List<DetailModel>>(
        future: categorys,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                DetailModel categorys = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "·${categorys.categoryName.toString()}",
                    style: ProjectTextStyles.instance.movieInfoYear,
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  SizedBox _actors() {
    return SizedBox(
      height: 100,
      child: FutureBuilder<List<ActorModel>>(
        future: actors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              /// get first 7 actors
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                ActorModel actor = snapshot.data![index];

                return _actorItems(actor);
              },
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Padding _actorItems(ActorModel actor) {
    return Padding(
        padding: const ProjectPadding.halfAll(),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(48.0),
                    child: Image.network(
                        AppEnvironmentItems.imageBaseUrl.value +
                            (actor.profilePath ?? " ")),
                  ),
                ),
                Padding(
                  padding: const ProjectPadding.halfAll(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        actor.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        actor.character ?? "",
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  Padding _watchTrailerButton() {
    return Padding(
      padding: const ProjectPadding.allWithoutTop(),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(LocaleKeys.buttonNames_watchTrailer).tr(),
            ),
          ),
        ],
      ),
    );
  }

  Text _movieOverview() {
    return Text(
      widget.movie.overview ?? "",
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: ProjectTextStyles.instance.movieInfoDesc,
    );
  }

  Row _movieTitle() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 2 / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: widget.movie.title,
                      style: ProjectTextStyles.instance.movieInfoTitle,
                      children: [
                    TextSpan(
                      text: " ${widget.movie.releaseDate?.substring(0, 4)}",
                      style: ProjectTextStyles.instance.movieInfoYear,
                    )
                  ])),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            const Icon(
              Icons.star_rate_rounded,
            ),
           
            Text(
              widget.movie.voteAverage!.toStringAsFixed(2) ,
              style: ProjectTextStyles.instance.movieInfoDesc,
            ),
          ],
        ),
      ],
    );
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
                    child: ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                          stops: [0.0, 1.0],
                        ).createShader(bounds);
                      },
                      child: Image.network(ImageModel()
                          .pathToImage(image.filePath ?? "")
                          .toString()),
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

  Padding _addTheWatchlistButton() {
    return Padding(
      padding: const ProjectPadding.all(),
      child: SizedBox(
          width: double.infinity,
          child: Consumer<WatchlistViewmodel>(
            builder: (context, value, child) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  value.addMovieToWatchlist(widget.movie);
                 
                },
                child: const Text(LocaleKeys.buttonNames_addTheWatchListButton)
                    .tr()),
          )),
    );
  }
}
