import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../components/movie_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/movie_api.dart';
import '../model/result_res.dart';
import '../components/now_playing_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/snackbar.dart';

class AllMovies extends StatefulWidget {
  const AllMovies({Key? key}) : super(key: key);

  @override
  State<AllMovies> createState() => _AllMoviesState();
}

class _AllMoviesState extends State<AllMovies> {
  List<Result> upcomingMovies = [];
  List<Result> popularMovies = [];
  List<Result> nowPlayingMovies = [];

  getUpcomingMovies() async {
    List<Result> res = await API().getMovieList("upcoming");
    setState(() {
      upcomingMovies = res;
    });
  }

  getPopularMovies() async {
    List<Result> res = await API().getMovieList("popular");
    setState(() {
      popularMovies = res;
    });
  }

  getNowPlayingMovies() async {
    List<Result> res = await API().getMovieList("now_playing");
    setState(() {
      nowPlayingMovies = res;
    });
  }

  checkLogin() {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  void initState() {
    checkLogin();
    getUpcomingMovies();
    getPopularMovies();
    getNowPlayingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: Colors.grey[900],
          backgroundColor: Colors.blueAccent[400],
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Home",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // Navigator.pop(context);
                    checkLogin();
                    showSnackbar(
                        context, "Logout successful !", 3, Colors.green);
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Now Playing",
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  (nowPlayingMovies.isEmpty)
                      ? SizedBox(
                          height: 220,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: Colors.grey[700],
                              size: 40.0,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: popularMovies.length,
                              itemBuilder: (context, index) {
                                return NowPlaying(
                                  title: nowPlayingMovies[index].title,
                                  image: nowPlayingMovies[index].posterPath,
                                  releaseDate: nowPlayingMovies[index]
                                      .releaseDate
                                      .toString(),
                                  overview: nowPlayingMovies[index].overview,
                                  backImg: nowPlayingMovies[index].backdropPath,
                                  rating: nowPlayingMovies[index].voteAverage,
                                  movieId: nowPlayingMovies[index].id,
                                );
                              }),
                        ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Popular",
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  (popularMovies.isEmpty)
                      ? SizedBox(
                          height: 220,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: Colors.grey[700],
                              size: 40.0,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 230,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: popularMovies.length,
                              itemBuilder: (context, index) {
                                return MovieCard(
                                  title: popularMovies[index].title,
                                  image: popularMovies[index].posterPath,
                                  releaseDate: popularMovies[index]
                                      .releaseDate
                                      .toString(),
                                  overview: popularMovies[index].overview,
                                  backImg: popularMovies[index].backdropPath,
                                  rating: popularMovies[index].voteAverage,
                                  movieId: popularMovies[index].id,
                                );
                              }),
                        ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Upcoming movie",
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  (upcomingMovies.isEmpty)
                      ? SizedBox(
                          height: 250,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: Colors.grey[700],
                              size: 40.0,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 220,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: upcomingMovies.length,
                              itemBuilder: (context, index) {
                                return MovieCard(
                                  title: upcomingMovies[index].title,
                                  image: upcomingMovies[index].posterPath,
                                  releaseDate: upcomingMovies[index]
                                      .releaseDate
                                      .toString(),
                                  overview: upcomingMovies[index].overview,
                                  backImg: upcomingMovies[index].backdropPath,
                                  rating: upcomingMovies[index].voteAverage,
                                  movieId: upcomingMovies[index].id,
                                );
                              }),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
