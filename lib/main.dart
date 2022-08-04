import 'package:flutter/material.dart';
import 'allmovieScreen.dart';
import 'movieDetail.dart';

void main() => runApp(upcoming_movie());

class upcoming_movie extends StatelessWidget {
  const upcoming_movie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "Main",
      initialRoute: "/",
      routes: {
        "/":(context) => const allMovies(), 
        "/detail" : (context) => const movieDetail()
      },
    );
  }
}
