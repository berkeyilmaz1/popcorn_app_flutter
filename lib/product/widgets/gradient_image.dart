import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/model/popular_movies_model.dart';
import 'package:movie_app/feature/movie_card_info/image_model.dart';
import 'package:movie_app/product/constants/strings.dart';
import 'package:movie_app/product/constants/text_styles.dart';
import 'package:movie_app/product/enums/locales.dart';
import 'package:movie_app/product/extensions/extensions.dart';
import 'package:movie_app/product/localization/locale_keys.g.dart';
import 'package:movie_app/product/services/image_services.dart';

class GradientImage extends StatefulWidget {
  const GradientImage({super.key, required this.movie});
  final Movie movie;

  @override
  State<GradientImage> createState() => _GradientImageState();
}

class _GradientImageState extends State<GradientImage> {
  late Future<List<ImageModel>>? images;
  final ImageServices _imageService = ImageServices();

  @override
  void initState() {
    super.initState();
    images = _imageService.fetchImages(widget.movie.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [_shaderEffect(), _watchButton()],
      ),
    );
  }

  ElevatedButton _watchButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Köşe yuvarlama miktarı
        ),
      ),
      onPressed: () {},
      child: Text(
        context.locale == Locales.tr
            ? "${widget.movie.title} ${LocaleKeys.headers_watch.tr()}"
            : "${LocaleKeys.headers_watch.tr()} ${widget.movie.title}",
        style: ProjectTextStyles.instance.headerTextStyles,
      ),
    );
  }

  ShaderMask _shaderEffect() {
    return ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
            stops: [0.0, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: _imageFutureBuilder());
  }

  FutureBuilder<List<ImageModel>> _imageFutureBuilder() {
    return FutureBuilder<List<ImageModel>>(
      future: images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          ///First image of the first movie
          ImageModel image = snapshot.data![0];
          return _movieImage(context, image);
        } else {
          return Center(child: Text(StringConstants.instance.noDataFound));
        }
      },
    );
  }

  SizedBox _movieImage(BuildContext context, ImageModel image) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Padding(
          padding: const ProjectPadding.halfAll(),
          child: Image.network(
            ImageModel().pathToImage(image.filePath ?? "").toString(),
          ),
        ));
  }
}
