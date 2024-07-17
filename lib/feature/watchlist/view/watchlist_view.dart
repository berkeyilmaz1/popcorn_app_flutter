import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/feature/watchlist/viewmodel/watchlist_viewmodel.dart';
import 'package:popcorn/product/constants/items.dart';
import 'package:popcorn/product/constants/text_styles.dart';
import 'package:popcorn/product/extensions/extensions.dart';
import 'package:popcorn/product/localization/locale_keys.g.dart';
import 'package:provider/provider.dart';

class WatchListView extends StatefulWidget {
  const WatchListView({super.key});

  @override
  State<WatchListView> createState() => _WatchListViewState();
}

class _WatchListViewState extends State<WatchListView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistViewmodel>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: _gotoTopButton(value),
        body: Padding(
          padding: const ProjectPadding.all(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _watchlistHeader().tr(),
              const SizedBox(height: 20),
              _moviesGridview(value),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _gotoTopButton(WatchlistViewmodel value) {
    return FloatingActionButton(
      onPressed: () {
        value.scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
      child: const Icon(Icons.arrow_upward_rounded),
    );
  }

  Expanded _moviesGridview(WatchlistViewmodel provider) {
    return Expanded(
      child: Consumer<WatchlistViewmodel>(
        builder: (context, value, child) => GridView.builder(
          controller: value.scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: provider.watchlist.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = provider.watchlist[index];
            var src = "https://image.tmdb.org/t/p/w500${movie.posterPath}";
            return Padding(
              padding: const ProjectPadding.allWithoutTop(),
              child: Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    const SizedBox(
                      width: 200,
                      height: 200,
                    ),
                    GestureDetector(
                      onTap: () {
                        value.changeTappedValue();
                      },
                      child: Image.network(src),
                    ),
                    _deleteButtonPosition(index),
                    value.isTapped == true
                        ? _deleteButton(value, movie)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Positioned _deleteButtonPosition(int index) {
    return Positioned(
                      left: 2,
                      child: Text((index + 1).toString(),
                          style:
                              ProjectTextStyles.instance.topRatedTextStyle));
  }

  Positioned _deleteButton(WatchlistViewmodel value, Movie movie) {
    return Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: Colors.white.withOpacity(0.85),
                            child: IconButton(
                                onPressed: () {
                                  value.removeMovieFromWatchlist(movie);
                                  value.isTapped = false;
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: ProjectColors.instance.red,
                                )),
                          ));
  }

  Text _watchlistHeader() {
    return Text(
      LocaleKeys.headers_myWatchlist,
      style: ProjectTextStyles.instance.headerTextStyles,
    );
  }
}
