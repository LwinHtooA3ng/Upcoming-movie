import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class movieDetail extends StatefulWidget {
  const movieDetail({Key? key}) : super(key: key);

  @override
  State<movieDetail> createState() => _movieDetailState();
}

class _movieDetailState extends State<movieDetail> {
  var data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    var backImg = data['backImg'];

    var movieId = data['movieId'];

    var rating = data['rating'];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
              const SizedBox(
                height: 5,
              ),
              CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/original$backImg",
                placeholder: (context, url) => const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  // child: CircularProgressIndicator(),
                  child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 40.0,
                  ),
                )),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      style: TextStyle(
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data['overview'],
                      style: TextStyle(letterSpacing: 1, fontSize: 12, color: Colors.grey[300]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          infoCard(icon: Icons.star, info: "$rating", text: "Rating"),
                          infoCard(icon: Icons.date_range, info: data["releaseDate"], text: "Release Date"),
                          infoCard(icon: Icons.numbers, info: "$movieId", text: "Movie Id"),
                        ],
                      ),
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

Widget infoCard({icon, info, text}) {
  return SizedBox(
    width: 100,
    height:100,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(
              height: 6,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 10),
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
