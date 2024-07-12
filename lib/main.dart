import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/viewmodel/home_viewmodel.dart';
import 'package:movie_app/feature/tab/tab_view.dart';
import 'package:movie_app/product/init/config/app_environment.dart';
import 'package:movie_app/product/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  AppEnvironment.general();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewmodel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          title: 'Material App',
          home: const MovieTabView()),
    );
  }
}
