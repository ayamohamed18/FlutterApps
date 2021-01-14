import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:roovies/Helpers/dummy_data.dart';
import 'package:roovies/Models/user.dart';
import 'package:roovies/Providers/movies_provider.dart';
import 'package:roovies/Providers/users_provider.dart';
import 'package:roovies/Screens/auth_screen.dart';
import 'package:roovies/Screens/movie_details_screen.dart';

class MoviesList extends StatefulWidget {
  final int genreId;
  MoviesList.byGenre(this.genreId);
  MoviesList.byTrending() : genreId = null;

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool firstRun, successful;
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
      bool done;
      if (widget.genreId != null) {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchMoviesByGenre(widget.genreId);
      } else {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchTrendingMovies();
      }
      setState(() {
        firstRun = false;
        successful = done;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45 - 48,
      width: MediaQuery.of(context).size.width,
      child: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (successful)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 140,
                  itemCount: (widget.genreId != null)
                      ? Provider.of<MoviesProvider>(context)
                          .moviesByGenre
                          .length
                      : Provider.of<MoviesProvider>(context)
                          .trendingMovies
                          .length,
                  itemBuilder: (context, index) {
                    final movie = (widget.genreId != null)
                        ? Provider.of<MoviesProvider>(context)
                            .moviesByGenre[index]
                        : Provider.of<MoviesProvider>(context)
                            .trendingMovies[index];
                    bool isFav =
                        context.read<MoviesProvider>().isFavorite(movie.id);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  MovieDetailsScreen.routeName,
                                  arguments: movie);
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Image.network(
                                    movie.posterUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      movie.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${movie.rating}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        RatingBar(
                                            initialRating: movie.rating / 2,
                                            allowHalfRating: true,
                                            ignoreGestures: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.all(2),
                                            itemSize: 10,
                                            itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                            onRatingUpdate: null),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 5,
                            child: InkWell(
                              onTap: () async {
                                bool refreshed = await context
                                    .read<UserProvider>()
                                    .refreshTokenIfNecessary();
                                if (refreshed) {
                                  User user =
                                      context.read<UserProvider>().currentUser;
                                  context
                                    ..read<MoviesProvider>()
                                        .toggleFavoriteStatus(movie, user);
                                } else {
                                  await showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Text('Error has occured'),
                                      content: Text(
                                          'Sorry, you have to login again.'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok'))
                                      ],
                                    ),
                                  );
                                  Navigator.of(context).pushReplacementNamed(
                                      AuthenticationScreen.routename);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0),
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  (isFav)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Error has occured',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
