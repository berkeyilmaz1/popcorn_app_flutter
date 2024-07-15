import 'dart:math';

import 'package:flutter/material.dart';
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/product/services/discover_movies_services.dart';
import 'package:popcorn/product/services/movies_services.dart';
import 'package:popcorn/product/widgets/gradient_image.dart';

class HomeViewmodel extends ChangeNotifier {
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> inTheatres;
  late Future<List<Movie>> discoverMovies;
  final MoviesServices _moviesService = MoviesServices();
  final DiscoverMoviesServices _discoverMoviesServices =
      DiscoverMoviesServices();

  String initLangCode = "tr";

  String langCodeChanger(String langCode) {
    langCode == "en" ? initLangCode = "en" : initLangCode = "tr";

    return initLangCode;
  }

  HomeViewmodel() {
    initializeMovies();
  }
  void initializeMovies() {
    popularMovies = _fetchMovies(_moviesService, "popular");
    upcomingMovies = _fetchMovies(_moviesService, "upcoming");
    topRatedMovies = _fetchMovies(_moviesService, "top_rated");
    inTheatres = _fetchMovies(_moviesService, "now_playing");
    discoverMovies = _discoverMoviesServices.fetchMovies(
        pageNumber: Random().nextInt(10), initLangCode);
  }

  Future<List<Movie>> _fetchMovies(
    MoviesServices service,
    String pathName,
  ) {
    return service.fetchMovies(pathName, initLangCode);
  }

  FutureBuilder getFirstMovieofPopular() {
    return FutureBuilder<List<Movie>>(
      future: popularMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No movies found');
        } else {
          // İlk elemanı almak
          Movie firstMovie = snapshot.data!.first;

          return GradientImage(
            movie: firstMovie,
          );
        }
      },
    );
  }
}
