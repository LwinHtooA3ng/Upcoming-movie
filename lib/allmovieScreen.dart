import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'movieCard.dart';

class allMovies extends StatefulWidget {
  const allMovies({Key? key}) : super(key: key);

  @override
  State<allMovies> createState() => _allMoviesState();
}

class _allMoviesState extends State<allMovies> {
  var movie = [];

  getUpcomingMovies() async {
    var uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=6fca727503a934e24b91325556f4ec8b&language=en-US&page=1");
    var res = await http.get(uri);

    if (res.statusCode == 200) {
      var result = jsonDecode(res.body);

      setState(() {
        movie = result["results"];
      });
    }
  }

  @override
  void initState() {
    getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      "Upcoming movie",
                      style: TextStyle(
                        color: Colors.blueAccent[400],
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                    ),
                    // Icon(Icons.search_rounded),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.logout)),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (movie.isEmpty)
                        ? const Center(
                            child: SpinKitThreeBounce(
                              color: Colors.grey,
                              size: 40.0,
                            ),
                          )
                        : Flexible(
                            // flex: 3,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: movie.length,
                                itemBuilder: (context, index) {
                                  // return Text(movie[index]["original_title"]);
                                  var title = movie[index]["title"];
                                  var image = movie[index]["poster_path"];
                                  var releaseDate =
                                      movie[index]["release_date"];
                                  var overview = movie[index]["overview"];
                                  var backImg = movie[index]["backdrop_path"];
                                  dynamic rating = movie[index]["vote_average"];
                                  dynamic movieId = movie[index]["id"];
                                  return movieCard(
                                    title: title,
                                    image: image,
                                    releaseDate: releaseDate,
                                    overview: overview,
                                    backImg: backImg,
                                    rating: rating,
                                    movieId: movieId,
                                  );
                                }),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
