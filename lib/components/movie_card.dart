import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCard extends StatelessWidget {
  String title;
  String overview;
  String releaseDate;
  String image;
  String backImg;
  dynamic rating;
  dynamic movieId;

  MovieCard(
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
      child: SizedBox(
        width: 120,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/original$image",
                width: 120,
                placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 150,
                      child: Center(
                        child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SpinKitFadingCube(
                        color: Colors.grey[700],
                        size: 30.0,
                                        ),
                                      ),
                      ),
                    )),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(height: 5,),
            Text(title, style: GoogleFonts.openSans(fontSize: 10, color: Colors.grey[800], fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis, maxLines: 2,),
            // Row(
            //   children: [
            //     Icon(Icons.star, color: Colors.amber,size: 14,),
            //     Text("$rating", style: GoogleFonts.openSans(fontSize: 10, color: Colors.grey[600]))
            //   ],
            // ),
            ],
          ),
        ),
      ),
    );
  }
}
