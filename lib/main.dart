import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/movie_detail.dart';
import 'screens/register.dart';
import 'screens/login.dart';
import 'screens/landing.dart';

void main() => runApp(MovieInfo());

class MovieInfo extends StatelessWidget {
  const MovieInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      theme: ThemeData(
        // brightness: Brightness.dark,
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
        "/": (context) => const StartScreen(),
        "/movies": (context) => const AllMovies(),
        "/detail": (context) => const MovieDetails(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage()
      },
    );
  }
}
