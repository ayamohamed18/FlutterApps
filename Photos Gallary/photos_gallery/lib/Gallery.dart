import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> quotes = [
    'Lost time is never found again',
    'If there is no risk,there is no reward',
    'Everything will get better in time',
    'When you play a violin piece,you are a storyteller, and you are telling a story',
    'Listen to silence. it has so much to say',
  ];
  List<dynamic> images = [
    Image.asset('assets/images/artworks-000272516543-xwhpez-t500x500.jpg'),
    Image.asset('assets/images/image.jpg'),
    Image.asset('assets/images/Patience-and-how-to-develop-it.jpg'),
    Image.asset(
        'assets/images/Senior-girl-sunset-playing-violin-silhouette.jpg'),
    Image.asset('assets/images/YEc7WB6ASDydBTw6GDlF_antalya-beach-lulu.jpg'),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: Text('Photos Gallery'),
      ),
      body: Center(
          child: (index < 5)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quotes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    images[index],
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          index++;
                        });
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.blue[900],
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          index--;
                        });
                      },
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.blue[900],
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/tenor.gif'),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      child: Text(
                        'Show Again',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.pink[400],
                        ),
                      ),
                      color:Colors.blue[900],
                    )
                  ],
                )),
    );
  }
}
