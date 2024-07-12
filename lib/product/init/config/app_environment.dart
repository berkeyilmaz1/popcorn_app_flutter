import 'package:flutter/foundation.dart';
import 'package:movie_app/product/init/config/app_configuration.dart';
import 'package:movie_app/product/init/config/dev_env.dart';
 

final class AppEnvironment {
  AppEnvironment.setup({required AppConfiguration config}) {
    _config = config;
  }

  AppEnvironment.general() {
    _config = kDebugMode ? DevEnv() : DevEnv();
  }

  static late final AppConfiguration _config;
  static String get apiKey => _config.apiKey;
}

enum AppEnvironmentItems {
  apiKey;

  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.apiKey:
          return AppEnvironment._config.apiKey;
      }
    } catch (e) {
      throw Exception('AppEnvironment is not initialized.');
    }
  }
}
