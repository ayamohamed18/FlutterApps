import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:roovies/Helpers/dummy_data.dart';
import 'package:roovies/Models/movie.dart';
import 'package:roovies/Providers/movies_provider.dart';

class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: PageIndicatorContainer(
        indicatorSelectorColor: Theme.of(context).accentColor,
        shape: IndicatorShape.circle(size: 5),
        padding: EdgeInsets.all(5),
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            assert(index != null);
            return Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  Provider.of<MoviesProvider>(context)
                      .nowPlayingMovies[index]
                      .backPosterUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0, 0.9],
                )),
              ),
              Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  left: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: Theme.of(context).accentColor,
                      size: 50,
                    ),
                    onPressed: () {},
                  )),
              Positioned(
                bottom: 50,
                left: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    Provider.of<MoviesProvider>(context)
                        .nowPlayingMovies[index]
                        .title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ]);
          },
        ),
        length: 5,
      ),
    );
  }
}