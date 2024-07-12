import 'package:flutter/material.dart';
import 'package:movie_app/feature/favorites/view/favorites_view.dart';
import 'package:movie_app/feature/home/view/home_view.dart';
import 'package:movie_app/feature/search/view/search_view.dart';
import 'package:movie_app/product/constants/strings.dart';
import 'package:movie_app/product/constants/text_styles.dart';
import 'package:movie_app/product/enums/icon_enums.dart';

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
        appBar: _appBar(),
        bottomNavigationBar: _bottomNavBar(),
        body: _bodyTabBar(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        StringConstants.instance.appName,
        style: ProjectTextStyles.instance.appNameStyle,
      ),
    );
  }

  BottomAppBar _bottomNavBar() {
    return BottomAppBar(
      child: TabBar(tabs: [
        Tab(
          icon: IconEnums.getIcon(IconEnums.homeOutlined),
        ),
        Tab(
          icon: IconEnums.getIcon(IconEnums.favoriteBorderRounded),
        ),
        Tab(
          icon: IconEnums.getIcon(IconEnums.searchRounded),
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
