import 'package:flutter/material.dart';
import 'package:popcorn/feature/home/view/home_view.dart';
import 'package:popcorn/feature/search/view/search_view.dart';
import 'package:popcorn/feature/watchlist/view/watchlist_view.dart';
import 'package:popcorn/feature/welcome_page/welcome_page.dart';
import 'package:popcorn/product/constants/strings.dart';
import 'package:popcorn/product/constants/text_styles.dart';
import 'package:popcorn/product/enums/icon_enums.dart';

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
        appBar: _appBar(context),
        bottomNavigationBar: _bottomNavBar(),
        body: _bodyTabBar(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                  (route) => false,
                ),
            icon: const Icon(Icons.exit_to_app_rounded))
      ],
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
      WatchListView(),
      SearchView(),
    ]);
  }
}
