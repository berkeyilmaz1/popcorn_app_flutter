import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popcorn/feature/home/viewmodel/home_viewmodel.dart';
import 'package:popcorn/feature/tab/tab_view.dart';
import 'package:popcorn/product/constants/strings.dart';
import 'package:popcorn/product/enums/locales.dart';
import 'package:popcorn/product/extensions/extensions.dart';
import 'package:popcorn/product/localization/localization.dart';
import 'package:provider/provider.dart';

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
      child: Consumer<HomeViewmodel>(
        builder: (context, provider, child) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _trFlag(context, provider),
            const SizedBox(
              width: 30,
            ),
            _enFlag(context, provider)
          ],
        ),
      ),
    );
  }

  GestureDetector _trFlag(BuildContext context, HomeViewmodel provider) {
    const String trFlagPath_ = "assets/images/ic_tr_flag.svg";
    return GestureDetector(
      onTap: () {
        ProductLocalization.updateLanguage(context: context, value: Locales.tr);
        provider.langCodeChanger("tr");
        provider.initializeMovies();
        _langMessage(context, StringConstants.instance.langTrMessage);
      },
      child: SvgPicture.asset(
        trFlagPath_,
        height: 50,
        width: 50,
      ),
    );
  }

  void _langMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 400), content: Text(message)));
  }

  GestureDetector _enFlag(BuildContext context, HomeViewmodel provider) {
    const String enFlagPath_ = "assets/images/ic_us_flag.svg";

    return GestureDetector(
      onTap: () {
        ProductLocalization.updateLanguage(context: context, value: Locales.en);
        provider.langCodeChanger("en");
        provider.initializeMovies();
        _langMessage(context, StringConstants.instance.langEnMessage);
      },
      child: SvgPicture.asset(
        enFlagPath_,
        height: 50,
        width: 50,
      ),
    );
  }
}
