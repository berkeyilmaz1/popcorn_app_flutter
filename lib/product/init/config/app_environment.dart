import 'package:popcorn/product/init/config/app_configuration.dart';

final class AppEnvironment {
  AppEnvironment.setup({required AppConfiguration config}) {
    _config = config;
  }

  static late final AppConfiguration _config;
}

enum AppEnvironmentItems {
  apiKey,
  imageBaseUrl,
  moviesServiceUrl,
  imagesServiceUrl,
  discoverServiceUrl,
  getActorBaseUrl,
  getActorApiKey,
  getDetailBaseUrl,
  getDetailApikey;

  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.apiKey:
          return AppEnvironment._config.apiKey;

        case AppEnvironmentItems.imageBaseUrl:
          return AppEnvironment._config.imageBaseUrl;
        case AppEnvironmentItems.moviesServiceUrl:
          return AppEnvironment._config.moviesServiceUrl;
        case AppEnvironmentItems.imagesServiceUrl:
          return AppEnvironment._config.imagesServiceUrl;
        case AppEnvironmentItems.discoverServiceUrl:
          return AppEnvironment._config.discoverServiceUrl;
        case AppEnvironmentItems.getActorBaseUrl:
          return AppEnvironment._config.getActorBaseUrl;
        case AppEnvironmentItems.getActorApiKey:
          return AppEnvironment._config.getActorApiKey;
        case AppEnvironmentItems.getDetailBaseUrl:
          return AppEnvironment._config.getDetailBaseUrl;
        case AppEnvironmentItems.getDetailApikey:
          return AppEnvironment._config.getDetailApikey;
      }
    } catch (e) {
      throw Exception('AppEnvironment is not initialized.');
    }
  }
}
