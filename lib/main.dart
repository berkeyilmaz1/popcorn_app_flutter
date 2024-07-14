import 'package:Popcorn/feature/home/viewmodel/home_viewmodel.dart';
import 'package:Popcorn/feature/welcome_page/welcome_page.dart';
import 'package:Popcorn/product/init/config/app_environment.dart';
import 'package:Popcorn/product/init/config/dev_env.dart';
import 'package:Popcorn/product/localization/localization.dart';
import 'package:Popcorn/product/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewmodel(),
        ),
      ],
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
