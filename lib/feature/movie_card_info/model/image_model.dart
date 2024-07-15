class ImageModel {
  String? filePath;

  ImageModel({
    this.filePath,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  String pathToImage(String path) {
    return "https://image.tmdb.org/t/p/w500$path";
  }
}
