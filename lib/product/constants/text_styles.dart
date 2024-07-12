import 'package:flutter/material.dart';

class ProjectTextStyles {
  ProjectTextStyles._();

  static ProjectTextStyles instance = ProjectTextStyles._();

  TextStyle get appNameStyle => const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      color: Colors.blue);

  TextStyle get headerTextStyles => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      );
  TextStyle get movieInfoTitle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      );
  TextStyle get movieInfoYear => const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 1,
      color: Colors.grey);

  TextStyle get movieInfoDesc => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      );

  TextStyle get movieInfoHeader => const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      overflow: TextOverflow.ellipsis);

  TextStyle get topRatedTextStyle => const TextStyle(
      letterSpacing: 2,
      shadows: [
        Shadow(
          color: Colors.black,
          blurRadius: 5,
        )
      ],
      fontWeight: FontWeight.bold,
      fontSize: 56);
}
