import 'package:flutter/material.dart';

class ProjectPadding extends EdgeInsets {
  const ProjectPadding.all() : super.all(12);
  const ProjectPadding.bigAll() : super.all(24);
  const ProjectPadding.halfAll() : super.all(6);
  const ProjectPadding.allWithoutTop() : super.only(bottom: 12,left: 12,right: 12);
  
}
