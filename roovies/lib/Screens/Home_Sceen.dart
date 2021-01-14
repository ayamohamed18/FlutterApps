import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/Models/user.dart';
import 'package:roovies/Providers/genres_provider.dart';
import 'package:roovies/Providers/movies_provider.dart';
import 'package:roovies/Providers/persons_provider.dart';
import 'package:roovies/Providers/users_provider.dart';
import 'package:roovies/Widgets/Now_Playing.dart';
import 'package:roovies/Widgets/genres_list.dart';
import 'package:roovies/Widgets/my_drawer.dart';
import 'package:roovies/Widgets/trending_movies.dart';
import 'package:roovies/Widgets/trending_persons.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstrun;
  bool successful;
  @override
  void initState() {
    super.initState();
    firstrun = true;
    successful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstrun) {
      bool done = await context.read<UserProvider>().refreshTokenIfNecessary();
      User user = context.read<UserProvider>().currentUser;
      final responses = await Future.wait([
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchFavorites(user),
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchNowPlayingMovies(),
        Provider.of<GenresProvider>(context, listen: false).fetchGenres(),
        Provider.of<PersonsProvider>(context, listen: false)
            .fetchTrendingPersons(),
      ]);

      setState(() {
        successful =
            (!responses.any((element) => element = false) && done == true);
        firstrun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Mydrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Roovies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: (firstrun)
          ? Center(child: CircularProgressIndicator())
          : (successful)
              ? ListView(
                  children: [
                    NowPlaying(),
                    GenresList(),
                    TrendingPersons(),
                    TrendingMovies(),
                  ],
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
