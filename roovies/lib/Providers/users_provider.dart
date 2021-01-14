import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:roovies/Models/firebase_handler.dart';
import 'package:roovies/Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User currentUser;

  Future<void> saveUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', currentUser.email);
    sharedPreferences.setString('userId', currentUser.userId);
    sharedPreferences.setString('idToken', currentUser.idToken);
    sharedPreferences.setString('refreshToken', currentUser.refreshToken);
    sharedPreferences.setString(
        'expiryDate', currentUser.expiryDate.toString());
  }

  Future<void> removeUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    sharedPreferences.remove('userId');
    sharedPreferences.remove('idToken');
    sharedPreferences.remove('refreshToken');
    sharedPreferences.remove('expiryDate');
  }

  Future<String> register(String email, String pasword) async {
    try {
      currentUser = await FirebaseHandler.instance.register(email, pasword);
      saveUserData();
      return null;
    } on DioError catch (error) {
      String errorCode = error.response.data['error']['message'];
      if (errorCode == 'EMAIL_EXISTS') {
        return 'The email address is already in use by another account.';
      } else {
        return 'We have blocked all requests from this device due to unusual activity. Try again later.';
      }
    }
  }

  Future<String> login(String email, String pasword) async {
    try {
      currentUser = await FirebaseHandler.instance.login(email, pasword);
      saveUserData();
      return null;
    } on DioError catch (error) {
      String errorCode = error.response.data['error']['message'];
      if (errorCode == 'EMAIL_NOT_FOUND') {
        return 'There is no user record corresponding to this identifier. The user may have been deleted.';
      } else if (errorCode == 'INVALID_PASSWORD') {
        return 'The password is invalid or the user does not have a password.';
      } else {
        return 'The user account has been disabled by an administrator.';
      }
    }
  }

  Future<bool> loggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('idToken')) {
      currentUser = User.fromprefrences(sharedPreferences);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> refreshTokenIfNecessary() async {
    if (DateTime.now().isAfter(currentUser.expiryDate)) {
      try {
        currentUser = await FirebaseHandler.instance.refreshToken(currentUser);
        return true;
      } catch (error) {
        return false;
      }
    } else {
      return true;
    }
  }
}
