import 'package:flutter/material.dart';
import 'package:popcorn/feature/home/model/movie_model.dart';

class WatchlistViewmodel extends ChangeNotifier {
  final List<Movie> watchlist = [];

  bool isTapped = false;

  void changeTappedValue() {
    isTapped = !isTapped;
    notifyListeners();
  }

  void addMovieToWatchlist(Movie? movie) {
    if (movie != null) {
      if (watchlist.contains(movie)) {
        return;
      }
      watchlist.add(movie);
    }

    notifyListeners();
  }

  void removeMovieFromWatchlist(Movie? model) {
    if (model != null) {
      watchlist.remove(model);
      notifyListeners();
    }
  }
}
