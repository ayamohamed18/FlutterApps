import 'package:delivery_manager/screens/Home_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deliver Manager',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
