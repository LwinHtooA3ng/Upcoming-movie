import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class movieCard extends StatelessWidget {
  String title;
  String overview;
  String releaseDate;
  String image;
  String backImg;
  dynamic rating;
  dynamic movieId;

  movieCard(
      {Key? key,
      required this.title,
      required this.overview,
      required this.releaseDate,
      required this.image,
      required this.backImg,
      required this.rating,
      required this.movieId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail", arguments: {
          'title': title,
          'overview': overview,
          'releaseDate': releaseDate,
          'backImg': backImg,
          'rating': rating,
          'movieId' : movieId,
        });
      },
      child: Card(
        // color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: "https://image.tmdb.org/t/p/original$image",
                  width: 70,
                  placeholder: (context, url) => const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    // child: CircularProgressIndicator(),
                    child: SpinKitFadingCube(
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
                // child: Image.network(
                //   "https://image.tmdb.org/t/p/original$image",
                //   width: 70,
                // ),
              ),
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
                            color: Colors.grey[200],
                            fontSize: 12)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(overview,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            TextStyle(color: Colors.grey[300], fontSize: 11)),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(releaseDate,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                            fontSize: 10)),
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
