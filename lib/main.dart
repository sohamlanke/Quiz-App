import 'dart:async';
//import 'dart:js';
import 'dart:math';
import 'SecondScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Test.dart';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
  routes: {
       // '/': (context) => SecondScreen(),
    '/Test': (context) => Test(),
  },
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int colors_index;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Random_color_index();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SecondScreen()));
  }

  List _colors = [
    Colors.lightBlueAccent,
    Colors.limeAccent,
    Colors.lightGreenAccent,
    Colors.orange,
    Colors.pinkAccent,
    Colors.pink
  ];
  Random random = new Random();
  Random_color_index() {
    colors_index = random.nextInt(_colors.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _colors[colors_index],
        child: Center(
          child: Text(
            "Welcome Madhura :)",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
