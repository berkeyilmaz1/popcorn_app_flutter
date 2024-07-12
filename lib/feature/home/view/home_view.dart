import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/model/popular_movies_model.dart';
import 'package:movie_app/feature/home/viewmodel/home_viewmodel.dart';
import 'package:movie_app/product/constants/text_styles.dart';
import 'package:movie_app/product/extensions/extensions.dart';
import 'package:movie_app/product/widgets/gradient_image.dart';
import 'package:movie_app/product/widgets/movie_card.dart';
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
                  _headerText("Popular"),
                  _popularMovies(),
                  _headerText("Top Rated"),
                  _topRatedMovies(),
                  _headerText("Discover Movies"),
                  _discoverMovies(),
                  _headerText("Currently in Theatres"),
                  _inTheatres(),
                  _headerText("Upcoming"),
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
              return const Center(child: Text('No data found'));
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
              return const Center(child: Text('No data found'));
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
              return const Center(child: Text('No data found'));
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
              return const Center(child: Text('No data found'));
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
              return const Center(child: Text('No data found'));
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
    );
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
              return const Center(child: Text('No data found'));
            }
          },
        );
      },
    );
  }
}
