import 'package:flutter/material.dart';
import 'package:movie_app/feature/favorites/view/favorites_view.dart';
import 'package:movie_app/feature/home/view/home_view.dart';
import 'package:movie_app/feature/search/view/search_view.dart';
import 'package:movie_app/product/constants/strings.dart';
import 'package:movie_app/product/constants/text_styles.dart';

/// Enums for tabs.
enum TabEnums { home, favorites, search }

///Tab business for app.

class MovieTabView extends StatelessWidget {
  const MovieTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabEnums.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringConstants.instance.appName,style: ProjectTextStyles.instance.appNameStyle,),
        ),
        bottomNavigationBar: _bottomNavBar(),
        body: _bodyTabBar(),
      ),
    );
  }

  BottomAppBar _bottomNavBar() {
    return const BottomAppBar(
      child: TabBar(tabs: [
        Tab(
          icon: Icon(Icons.home_outlined),
        ),
        Tab(
          icon: Icon(Icons.favorite_border_rounded),
        ),
        Tab(
          icon: Icon(Icons.search_rounded),
        ),
      ]),
    );
  }

  TabBarView _bodyTabBar() {
    return const TabBarView(physics: NeverScrollableScrollPhysics(), children: [
      HomeView(),
      FavoritesView(),
      SearchView(),
    ]);
  }
}
