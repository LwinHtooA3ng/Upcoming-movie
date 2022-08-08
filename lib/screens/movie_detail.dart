import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    var backImg = data['backImg'];

    var movieId = data['movieId'];

    var rating = data['rating'];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blueAccent[400],
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children : [ 
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),color: Colors.white,),
                        Expanded(
                          child: Text(
                          data['title'],
                          style: GoogleFonts.ubuntu(
                            // overflow: TextOverflow.clip,
                            color: Colors.white,
                            letterSpacing: 1.4,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                                            ),
                        ),
                    ],
                  ),
                ),
              ),
              CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/original$backImg",
                placeholder: (context, url) => SizedBox(
                  height: 200,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: CircularProgressIndicator(),
                    child: SpinKitFadingCube(
                      color: Colors.grey[700],
                      size: 40.0,
                    ),
                  )),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Overview", style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    
                    Text(
                      data['overview'],
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        infoCard(
                            icon: Icons.star,
                            info: "$rating",
                            text: "Rating",
                            color: Colors.amber),
                        infoCard(
                            icon: Icons.date_range,
                            info: data["releaseDate"],
                            text: "Release Date"
                            ),
                        infoCard(
                            icon: Icons.numbers,
                            info: "$movieId",
                            text: "Movie Id"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget infoCard({icon, info, text, color}) {
  return SizedBox(
    width: 100,
    height: 100,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color,),
            const SizedBox(
              height: 6,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 10, color: Colors.grey[700]),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              info,
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    ),
  );
}
