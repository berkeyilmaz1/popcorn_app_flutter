class MovieLoadException implements Exception {
  @override
  String toString() {
    return 'Failed to load movies';
  }
}



class AppEnvIsNotInitException implements Exception {
  @override
  String toString() {
    return 'AppEnvironment is not initialized.';
  }
}

