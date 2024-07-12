import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/viewmodel/home_viewmodel.dart';
import 'package:movie_app/feature/welcome_page/welcome_page.dart';
import 'package:movie_app/product/init/config/app_environment.dart';
import 'package:movie_app/product/init/config/dev_env.dart';
import 'package:movie_app/product/localization/localization.dart';
import 'package:movie_app/product/theme/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppEnvironment.setup(config: DevEnv());

  runApp(
    ProductLocalization(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewmodel(),
      child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          title: 'Material App',
          home: const WelcomePage()),
    );
  }
}
