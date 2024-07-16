import 'package:flutter/material.dart';

class ProjectItems {
  ProjectItems._();
  static ProjectItems instance = ProjectItems._();

  BorderRadiusGeometry? get movieBoxRadius =>
      const BorderRadius.all(Radius.circular(8));
}

class ProjectColors {
  ProjectColors._();
  static ProjectColors instance = ProjectColors._();

  Color get white => Colors.white;
  Color get blue => Colors.blue;
  Color get black => Colors.black;
}
