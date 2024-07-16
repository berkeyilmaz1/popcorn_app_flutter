import 'package:flutter/material.dart';
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/feature/search/view/search_view.dart';
import 'package:popcorn/product/services/search_movie.dart';

abstract class SearchViewmodel extends State<SearchView>  {
    TextEditingController? searchController;
  final SearchService _searchService = SearchService();
  late Future<List<Movie>>? searchedMovies;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchMovie();
  }

  void searchMovie() {
    setState(() {
      searchedMovies =
          _searchService.searchMovies(searchController?.text ?? " ");
    });
  }

}