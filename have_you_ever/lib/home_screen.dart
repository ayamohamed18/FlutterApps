import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> questions = [
    'Have you ever wrote a letter?',
    'Have you ever smoked a cigarette?',
    'Have you ever been hit on by someone who was too old?',
    'Have you ever been on the radio or on television?',
    'Have you ever stayed awake for an entire night?',
    'Have you ever broken something, like a window, and ran away?',
    'Have you ever won a contest and received a prize?',
    'Have you ever met a famous person or a celebrity?',
  ];
  int index = 0, yescounter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Have You Ever!')),
      body: Center(
        child: (index < 5)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    questions[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        index++;
                        yescounter++;
                      });
                    },
                    child: Text(
                      'yes',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blueAccent,
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        index++;
                      });
                    },
                    child: Text(
                      'no',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blueAccent,
                  ),
                ],
              )
            : Column(
                children: [
                  (yescounter >= 3)
                      ? Image.asset('lib/assets/images/loser.png')
                      : Image.asset('lib/assets/images/winner.png'),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        index = 0;
                        yescounter = 0;
                        questions.shuffle();
                      });
                    },
                    child: Text('Play Again'),
                  )
                ],
              ),
      ),
    );
  }
}
