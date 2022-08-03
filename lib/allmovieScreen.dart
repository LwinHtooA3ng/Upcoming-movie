import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 28, horizontal: 10),
                child: Text("Upcoming movie", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, fontStyle: FontStyle.italic),),
              ),
              Flexible(
                flex: 3,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: movie.length,
                    itemBuilder: (context, index) {
                      // return Text(movie[index]["original_title"]);
                      var title = movie[index]["title"];
                      var image = movie[index]["poster_path"];
                      var releaseDate = movie[index]["release_date"];
                      var overview = movie[index]["overview"];
                      return movieCard(
                          title: title,
                          image: image,
                          releaseDate: releaseDate,
                          overview: overview);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget movieCard({title, image, releaseDate, overview}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                "https://image.tmdb.org/t/p/original$image",
                width: 70,
              )),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 12)),
                const SizedBox(
                  height: 10,
                ),
                Text(overview,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: Colors.grey[700], fontSize: 11)),
                const SizedBox(
                  height: 15,
                ),
                Text(releaseDate,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
