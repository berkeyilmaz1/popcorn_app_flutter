import 'package:flutter/material.dart';

enum IconEnums {
  homeOutlined,
  favoriteBorderRounded,
  searchRounded;

  static Icon getIcon(IconEnums icon) {
    switch (icon) {
      case IconEnums.homeOutlined:
        return const Icon(Icons.home_outlined);
      case IconEnums.favoriteBorderRounded:
        return const Icon(Icons.favorite_border_rounded);
      case IconEnums.searchRounded:
        return const Icon(Icons.search_rounded);
      default:
        throw Exception('No Icon');
    }
  }
}
