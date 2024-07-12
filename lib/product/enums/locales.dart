 
import 'package:flutter/material.dart';

enum Locales {
  tr(Locale('tr')),
  en(Locale('en'));

  final Locale locale;

  const Locales(this.locale);
}
