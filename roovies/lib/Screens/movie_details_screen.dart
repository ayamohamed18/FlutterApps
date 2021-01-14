import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/Models/movie.dart';
import 'package:roovies/Models/movie_details.dart';
import 'package:roovies/Providers/movies_provider.dart';
import 'package:roovies/Screens/video_screen.dart';
import 'package:roovies/Widgets/movie_info.dart';
import 'package:roovies/Widgets/movie_overview.dart';
import 'package:roovies/Widgets/movie_rating_bar.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = '/movie-details';

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetails movieDetails;
  Movie movie;
  bool firstRun, successful;
  String videoKey;
  @override
  void initState() {
    super.initState();
    firstRun = true;
    successful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      movie = ModalRoute.of(context).settings.arguments as Movie;
      List results = await Future.wait([
        context.read<MoviesProvider>().fetchMovieDetails(movie.id),
        context.read<MoviesProvider>().fetchVedioKeyByMovieId(movie.id),
      ]);
      setState(() {
        firstRun = false;
        if (!results.any((element) => element == null)) {
          successful = true;
          movieDetails = results[0];
          videoKey = results[1];
        } else {
          successful = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (movieDetails != null)
              ? SliverFab(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * 0.4,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Padding(
                          padding: EdgeInsets.only(
                            right: 75,
                          ),
                          child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        background: Stack(children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.network(
                              movie.backPosterUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor.withOpacity(0),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          )
                        ]),
                      ),
                      pinned: true,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(16.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            MovieRatingBar(movie.rating),
                            MovieOverview(movieDetails.overview),
                            MovieInfo(
                                movieDetails.budget.toString(),
                                movieDetails.duration.toString(),
                                movieDetails.releaseDate.toString()),
                          ],
                        ),
                      ),
                    )
                  ],
                  floatingPosition: FloatingPosition(right: 20),
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  floatingWidget: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return VideoScreen(videoKey);
                        },
                      ));
                    },
                    child: Icon(Icons.play_arrow),
                  ),
                )
              : Center(
                  child: Text('Error has occurred'),
                ),
    );
  }
}
