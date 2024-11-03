import 'package:flutter/material.dart';
import 'package:src/core/constants.dart';
import 'package:src/core/theme_app.dart';
import 'package:src/pages/movie_page.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: KAppName,
      theme: kThemeApp,
      home: MoviePage(),
    );
  }
}