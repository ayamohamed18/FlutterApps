import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/Helpers/Constants.dart';
import 'package:roovies/Providers/genres_provider.dart';
import 'package:roovies/Providers/movies_provider.dart';
import 'package:roovies/Providers/persons_provider.dart';
import 'package:roovies/Providers/users_provider.dart';
import 'package:roovies/Screens/Home_Sceen.dart';
import 'package:roovies/Screens/auth_screen.dart';
import 'package:roovies/Screens/movie_details_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MoviesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => GenresProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PersonsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roovies',
      theme: ThemeData(
        fontFamily: ('Poppins'),
        textTheme: TextTheme(
            headline6: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        )),
        primarySwatch: Constants.color,
        accentColor: Color.fromRGBO(245, 195, 15, 1),
        scaffoldBackgroundColor: Constants.color,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          future: Provider.of<UserProvider>(context, listen: false).loggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error Has Occured'),
              );
            } else if (snapshot.data == true) {
              return HomeScreen();
            } else {
              return AuthenticationScreen();
            }
          }),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        AuthenticationScreen.routename: (context) => AuthenticationScreen(),
      },
    );
  }
}
