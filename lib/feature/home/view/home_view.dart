import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/feature/home/model/movie_model.dart';
import 'package:popcorn/feature/home/viewmodel/home_viewmodel.dart';
import 'package:popcorn/product/constants/strings.dart';
import 'package:popcorn/product/constants/text_styles.dart';
import 'package:popcorn/product/extensions/extensions.dart';
import 'package:popcorn/product/localization/locale_keys.g.dart';
import 'package:popcorn/product/widgets/gradient_image.dart';
import 'package:popcorn/product/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final Movie firstMovie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const ProjectPadding.all(),
        child: SingleChildScrollView(
          child: Consumer<HomeViewmodel>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _gradientImage(),
                  _headerText((LocaleKeys.headers_popular)),
                  _popularMovies(),
                  _headerText((LocaleKeys.headers_topRated)),
                  _topRatedMovies(),
                  _headerText((LocaleKeys.headers_discoverMovies)),
                  _discoverMovies(),
                  _headerText((LocaleKeys.headers_inTheatres)),
                  _inTheatres(),
                  _headerText((LocaleKeys.headers_upcoming)),
                  _upcomingMovies()
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Consumer<HomeViewmodel> _gradientImage() {
    return Consumer<HomeViewmodel>(
      builder: (context, value, child) {
        return FutureBuilder<List<Movie>>(
          future: value.popularMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GradientImage(movie: snapshot.data![0]),
                ],
              );
            } else {
              return const Center(child: Text((LocaleKeys.errors_noData)));
            }
          },
        );
      },
    );
  }

  Consumer _popularMovies() {
    return Consumer<HomeViewmodel>(
      builder: (context, value, child) {
        return FutureBuilder<List<Movie>>(
          future: value.popularMovies,
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
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Movie movie = snapshot.data![index];

                    return MovieCard(
                      movie: movie,
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text(StringConstants.instance.noDataFound));
            }
          },
        );
      },
    );
  }

  Consumer<HomeViewmodel> _discoverMovies() {
    return Consumer<HomeViewmodel>(
      builder: (context, value, child) {
        return FutureBuilder<List<Movie>>(
          future: value.discoverMovies,
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
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Movie movie = snapshot.data![index];
                    return MovieCard(
                      movie: movie,
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text(StringConstants.instance.noDataFound));
            }
          },
        );
      },
    );
  }

  Consumer<HomeViewmodel> _inTheatres() {
    return Consumer<HomeViewmodel>(
      builder: (context, value, child) {
        return FutureBuilder<List<Movie>>(
          future: value.inTheatres,
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
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Movie movie = snapshot.data![index];
                    return MovieCard(
                      movie: movie,
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text(StringConstants.instance.noDataFound));
            }
          },
        );
      },
    );
  }

  Consumer<HomeViewmodel> _topRatedMovies() {
    return Consumer<HomeViewmodel>(
      builder: (context, value, child) {
        return FutureBuilder<List<Movie>>(
          future: value.topRatedMovies,
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
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Movie movie = snapshot.data![index];
                    return MovieCard(
                      isTopRated: true,
                      movie: movie,
                      indexNumber: index,
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text(StringConstants.instance.noDataFound));
            }
          },
        );
      },
    );
  }

  Text _headerText(String text) {
    return Text(
      text,
      style: ProjectTextStyles.instance.headerTextStyles,
    ).tr();
  }

  Consumer<HomeViewmodel> _upcomingMovies() {
    return Consumer<HomeViewmodel>(
      builder: (context, value, child) {
        return FutureBuilder<List<Movie>>(
          future: value.upcomingMovies,
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
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Movie movie = snapshot.data![index];
                    return MovieCard(
                      movie: movie,
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text(StringConstants.instance.noDataFound));
            }
          },
        );
      },
    );
  }
}
