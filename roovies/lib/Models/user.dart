import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String userId, email;
  String idToken, refreshToken;
  DateTime expiryDate;

  User.fromJason(dynamic json)
      : this.userId = json['localId'],
        this.email = json['email'],
        this.idToken = json['idToken'],
        this.refreshToken = json['refreshToken'],
        this.expiryDate =
            DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));

  User.fromprefrences(SharedPreferences preferences)
      : this.userId = preferences.getString('userId'),
        this.email = preferences.getString('email'),
        this.idToken = preferences.getString('idToken'),
        this.refreshToken = preferences.getString('refreshToken'),
        this.expiryDate = DateTime.parse(
          preferences.getString('expiryDate'),
        );
}
