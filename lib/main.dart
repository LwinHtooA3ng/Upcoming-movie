import 'package:flutter/material.dart';
import 'allmovieScreen.dart';
import 'movieDetail.dart';
import 'registerScreen.dart';
import 'loginScreen.dart';
import 'firstScreen.dart';

void main() => runApp(upcoming_movie());

class upcoming_movie extends StatelessWidget {
  const upcoming_movie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
      title: "Main",
      initialRoute: "/",
      routes: {
        "/": (context) => const startScreen(),
        "/movies": (context) => const allMovies(),
        "/detail": (context) => const movieDetail(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage()
      },
    );
  }
}
