import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TableScreen.dart';

import 'Test.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String inputText;
  String error_msg = "";

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    try {
      int.parse(s);
    } catch (exception) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void erase_msg() async {
    Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code
      setState(() {
        error_msg = "";
      });
    });
  }

  Future<bool> _onWillPop(){
    return showDialog(context: context,
    builder: (context) => AlertDialog(
      title: Text("Are you sure?"),
      content: Text("Do you want to exit the App?"),
      actions: <Widget>[
        FlatButton(
          child: Text("No"),
          onPressed: (){
            Navigator.of(context).pop(false);
          },
        ),
        FlatButton(
          child: Text("Yes"),
          onPressed: () => exit(0),
        )
      ],
    ))??  false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Enter your Table number :)",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 100,
                child: TextField(
                  onChanged: (text) {
                    inputText = text;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 175,
                color: Colors.green,
                child: FlatButton(
                  onPressed: () {
                    if (isNumeric(inputText)) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TableScreen(
                                    number: inputText,
                                  )));
                    } else {
                      erase_msg();
                      setState(() {
                        error_msg = "Enter valid number :(";
                      });
                    }
                  },
                  splashColor: Colors.lightBlueAccent,
                  child: Text(
                    "Create Table",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 175,
                height: 50,
                child: FlatButton(
                  color: Colors.pink,
                  splashColor: Colors.pinkAccent,
                  child: Text("QUIZ!",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Test()));
                  },
                ),
              ),
              Text(
                error_msg,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
