import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/model/popular_movies_model.dart';
import 'package:movie_app/product/services/discover_movies_services.dart';
import 'package:movie_app/product/services/movies_services.dart';

class HomeViewmodel extends ChangeNotifier {
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> inTheatres;
  late Future<List<Movie>> discoverMovies;
  final MoviesServices _moviesService = MoviesServices();
  final DiscoverMoviesServices _discoverMoviesServices =
      DiscoverMoviesServices();

  HomeViewmodel() {
    _initializeMovies();
  }

  void _initializeMovies() {
    popularMovies = _fetchMovies(_moviesService, "popular");
    upcomingMovies = _fetchMovies(_moviesService, "upcoming");
    topRatedMovies = _fetchMovies(_moviesService, "top_rated");
    inTheatres = _fetchMovies(_moviesService, "now_playing");
    discoverMovies =
        _discoverMoviesServices.fetchMovies(pageNumber: Random().nextInt(10));
  }

  Future<List<Movie>> _fetchMovies(MoviesServices service, String pathName) {
    return service.fetchMovies(pathName);
  }
}
