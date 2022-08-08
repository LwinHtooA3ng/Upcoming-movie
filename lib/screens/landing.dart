import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.grey[100]),
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/movie_bg.jpg",),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Movie info", style: GoogleFonts.ubuntu(fontSize: 25, color : Colors.blueAccent[400], fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent[400]),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text("Login"))),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          side: const BorderSide(width: 1, color: Colors.blue)
                        ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text("Register"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}