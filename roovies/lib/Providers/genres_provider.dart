import 'package:flutter/material.dart';
import 'package:roovies/Models/genre.dart';
import 'package:roovies/Models/tmdb_handler.dart';

class GenresProvider with ChangeNotifier {
  List<Genre> genres;
  Future<bool> fetchGenres() async {
    try {
      genres = await TmdbHandler.instance.getgenres();
      return true;
    } catch (error) {
      return false;
    }
  }
}
