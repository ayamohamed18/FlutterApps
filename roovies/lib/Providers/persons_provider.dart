import 'package:flutter/material.dart';
import 'package:roovies/Models/person.dart';
import 'package:roovies/Models/tmdb_handler.dart';

class PersonsProvider with ChangeNotifier {
  List<Person> trendingPersons;

  Future<bool> fetchTrendingPersons() async {
    try {
      trendingPersons = await TmdbHandler.instance.getTrendingPersons();
      return true;
    } catch (error) {
      return false;
    }
  }
}
