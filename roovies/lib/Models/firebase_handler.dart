import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:roovies/Helpers/Api_keys.dart';
import 'package:roovies/Models/movie.dart';
import 'package:roovies/Models/user.dart';

class FirebaseHandler {
  static FirebaseHandler _instance = FirebaseHandler._private();
  FirebaseHandler._private();
  static FirebaseHandler get instance => _instance;
  Dio _dio = Dio();

  Future<Void> addFavorite(Movie movie, User user) async {
    String url =
        'https://roovies-7b0ea-default-rtdb.firebaseio.com/users/${user.userId}/favorites/${movie.id}.json';
    final parms = {
      "auth": user.idToken,
    };
    await _dio.put(
      url,
      queryParameters: parms,
      data: {
        'id': movie.id,
        'title': movie.title,
        'vote_average': movie.rating,
        'poster_path': movie.posterUrl.split('/').last,
        'backdrop_path': movie.backPosterUrl.split('/').last
      },
    );
  }

  Future<Void> deleteFavorite(Movie movie, User user) async {
    String url =
        'https://roovies-7b0ea-default-rtdb.firebaseio.com/users/${user.userId}/favorites/${movie.id}.json';
    final parms = {
      "auth": user.idToken,
    };
    await _dio.delete(
      url,
      queryParameters: parms,
    );
  }

  Future<User> register(String email, String pasword) async {
    String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp';
    final parms = {
      'key': ApiKeys.firebaseKey,
    };
    Response response = await _dio.post(
      url,
      queryParameters: parms,
      data: {
        'email': email,
        'password': pasword,
        'returnSecureToken': true,
      },
    );
    return User.fromJason(response.data);
  }

  Future<User> login(String email, String pasword) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
    final parms = {
      'key': ApiKeys.firebaseKey,
    };
    Response response = await _dio.post(
      url,
      queryParameters: parms,
      data: {
        'email': email,
        'password': pasword,
        'returnSecureToken': true,
      },
    );
    return User.fromJason(response.data);
  }

  Future<User> refreshToken(User user) async {
    String url = 'https://securetoken.googleapis.com/v1/token';
    final parms = {
      'key': ApiKeys.firebaseKey,
    };
    Response response = await _dio.post(
      url,
      queryParameters: parms,
      data: {
        'grant_type': 'refresh_token',
        'refresh_token': user.refreshToken,
      },
    );
    user.refreshToken = response.data['refresh_token'];
    user.idToken = response.data['id_token'];
    user.expiryDate = DateTime.now().add(Duration(
      seconds: int.parse(response.data['expires_in']),
    ));
    return user;
  }

  Future<List<Movie>> getFavourites(User user) async {
    String url =
        'https://roovies-7b0ea-default-rtdb.firebaseio.com/users/${user.userId}/favorites/.json';
    final parms = {
      "auth": user.idToken,
    };
    Response response = await _dio.get(url, queryParameters: parms);
    if (response.data != null) {
      return (response.data as Map)
          .entries
          .map((e) => Movie.fromJson(e.value))
          .toList();
    } else {
      return [];
    }
  }
}
