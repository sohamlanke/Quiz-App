import 'package:flutter/material.dart';
import 'Test.dart';

class Score_card extends StatelessWidget {
  int marks, count, min, max; // taking min, max to pass again when "play again" button clicked
  Score_card({this.marks, this.count, this.min, this.max});
  @override
  Widget build(BuildContext context) {
    Widget bigCircle = new Container(
      width: 300.0,
      height: 300.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.lightGreen,
            width: 8,
          )),
    );
    String scoremsg() {
      if (marks/count * 100 >= 80) {
        return 'Woah! You are killig it';
      } else if (marks/count * 100 >= 60) {
        return 'Thats a good score!';
      } else {
        return 'Com\'on you can do better';
      }
    }

    Color scorecolor() {
      if (marks/count * 100 >= 80) {
        return Colors.green;
      } else if (marks/count * 100 >= 60) {
        return Colors.orangeAccent;
      } else {
        return Colors.redAccent;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Score Card"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              "Your Score is:",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 80,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                bigCircle,
                Container(
                    child: Column(
                  children: <Widget>[
                    Text("$marks", style: TextStyle(fontSize: 50)),
                    Container(
                      color: Colors.red,
                      width: 100,
                      height: 10,
                    ),
                    Text("$count", style: TextStyle(fontSize: 50)),
                  ],
                )),
              ],
            ),
            Expanded(flex: 1,
                child: Center(
                  child: Text(
              scoremsg(),
              style: TextStyle(
                    color: scorecolor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
            ),
                )),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 150,
                    child: FlatButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Test(min: min, max: max, count: count - 1,)));
                      },
                      child: Text(
                        "Play Again",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
