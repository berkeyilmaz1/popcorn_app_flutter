import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/feature/tab/tab_view.dart';
import 'package:movie_app/product/enums/locales.dart';
import 'package:movie_app/product/extensions/extensions.dart';
import 'package:movie_app/product/localization/localization.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _popcornLogo(context),
          const Spacer(),
          _flags(context),
        ],
      ),
    ));
  }

  SizedBox _popcornLogo(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MovieTabView(),
          ),
          (route) => false,
        ),
        child: Image.asset("assets/images/popcorn_logo.png"),
      ),
    );
  }

  Padding _flags(BuildContext context) {
    return Padding(
      padding: const ProjectPadding.bigAll(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              ProductLocalization.updateLanguage(
                  context: context, value: Locales.tr);
            },
            child: SvgPicture.asset(
              "assets/images/ic_tr_flag.svg",
              height: 50,
              width: 50,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: () {
              ProductLocalization.updateLanguage(
                  context: context, value: Locales.en);
            },
            child: SvgPicture.asset(
              "assets/images/ic_us_flag.svg",
              height: 50,
              width: 50,
            ),
          )
        ],
      ),
    );
  }
}
