import 'package:popcorn/product/enums/locales.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class ProductLocalization extends EasyLocalization  {
  ProductLocalization({
    super.key,
    required super.child,
  }) : super(
            supportedLocales: _supportedItems,
            path: _translationPath,
            useOnlyLangCode: true);

  static final List<Locale> _supportedItems = [
    Locales.tr.locale,
    Locales.en.locale,
  ];

  static const String _translationPath = "assets/translations";

  static Future<void> updateLanguage(
      {required BuildContext context, required Locales value}) async {
    await context.setLocale(value.locale);
  }
}
