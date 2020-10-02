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
        actions: <Widget>[
          IconButton(
              icon: Text(
                'Next',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              onPressed: () {
      setState(() {
                          index++;
                        });
              }),],
               leading:Builder(builder: (BuildContext context){return IconButton(
              icon: Text(
                'Prev',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              onPressed: () {
      setState(() {
                          index--;
                        });
              });}),
              
      ),
      body: Center(
          child: (index < 5 && index >= 0)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quotes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    images[index],
                   
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (index >= 5)
                        ? Image.asset('assets/images/tenor.gif')
                        : Text(
                            'Press here to show photos',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      child: Text(
                        'show Photos',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.pink[400],
                        ),
                      ),
                      color: Colors.blue[900],
                    )
                  ],
                )),
    );
  }
}
