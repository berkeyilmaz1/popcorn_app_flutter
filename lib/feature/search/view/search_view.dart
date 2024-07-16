import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/feature/movie_card_info/view/movie_card_info.dart';
import 'package:popcorn/feature/search/viewmodel/search_viewmodel.dart/search_viewmodel.dart';
import 'package:popcorn/product/constants/items.dart';
import 'package:popcorn/product/constants/text_styles.dart';
import 'package:popcorn/product/extensions/extensions.dart';
import 'package:popcorn/product/localization/locale_keys.g.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends SearchViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const ProjectPadding.all(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _searchHeader(),
            _searchBar(),
            Expanded(
              child: FutureBuilder<List<Movie>>(
                future: searchedMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return _movieList(snapshot.data!);
                  } else {
                    return const Center(child: Text('No data found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchHeader() {
    return Text(
      LocaleKeys.headers_search,
      style: ProjectTextStyles.instance.headerTextStyles,
    ).tr();
  }

  Widget _searchBar() {
    return Padding(
      padding: const ProjectPadding.all(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 2.5 / 4,
            child: SearchBar(
              controller: searchController,
              backgroundColor:
                  WidgetStatePropertyAll(ProjectColors.instance.white),
              leading: Icon(
                Icons.search,
                color: ProjectColors.instance.black,
              ),
              textStyle: WidgetStatePropertyAll(
                ProjectTextStyles.instance.headerTextStyles
                    .copyWith(color: ProjectColors.instance.black),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: searchMovie,
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieList(List<Movie> movies) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const ProjectPadding.halfAll(),
            child: ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MovieCardInfo(movie: movie),
              )),
              title: Text(
                movie.title ?? "",
                style: ProjectTextStyles.instance.headerTextStyles,
              ),
              subtitle: Text(
                movie.releaseDate ?? "",
                style: ProjectTextStyles.instance.movieInfoYear,
              ),
              leading: movie.posterPath != null
                  ? Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.posterPath}")
                  : null,
            ),
          );
        },
      ),
    );
  }
}
