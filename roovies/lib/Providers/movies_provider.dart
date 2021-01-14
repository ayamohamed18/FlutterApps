import 'package:flutter/foundation.dart';
import 'package:roovies/Models/firebase_handler.dart';
import 'package:roovies/Models/movie.dart';
import 'package:roovies/Models/movie_details.dart';
import 'package:roovies/Models/tmdb_handler.dart';
import 'package:roovies/Models/user.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> nowPlayingMovies;
  List<Movie> moviesByGenre;
  List<Movie> trendingMovies;
  List<Movie> favorits = [];

  Future<bool> fetchNowPlayingMovies() async {
    try {
      nowPlayingMovies = await TmdbHandler.instance.getNowPlaying();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchMoviesByGenre(int genreId) async {
    try {
      moviesByGenre = await TmdbHandler.instance.getMoviesByGenreId(genreId);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchTrendingMovies() async {
    try {
      trendingMovies = await TmdbHandler.instance.getTrendingMovies();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    try {
      MovieDetails movieDetails =
          await TmdbHandler.instance.getMovieDetails(movieId);
      return movieDetails;
    } catch (error) {
      print(error);
    }
  }

  Future<String> fetchVedioKeyByMovieId(int movieId) async {
    try {
      await TmdbHandler.instance.getVideoKeyByMovieId(movieId);
    } catch (e) {
      print(e);
    }
  }

  void toggleFavoriteStatus(Movie movie, User user) async {
    try {
      if (isFavorite(movie.id)) {
        await FirebaseHandler.instance.deleteFavorite(movie, user);
        favorits.removeWhere((element) => element.id == movie.id);
      } else {
        await FirebaseHandler.instance.addFavorite(movie, user);
        favorits.add(movie);
      }
      notifyListeners();
    } catch (e) {
      print(e.response.data);
    }
  }

  bool isFavorite(int movieId) {
    return favorits.any((element) => element.id == movieId);
  }

  Future<bool> fetchFavorites(User user) async {
    try {
      favorits = await FirebaseHandler.instance.getFavourites(user);
      return true;
    } catch (error) {
      return false;
    }
  }
}
