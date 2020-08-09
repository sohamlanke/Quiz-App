import 'dart:math';
import 'package:multiplicationtables1/SecondScreen.dart';
import 'package:flutter/services.dart';
import 'Score_card.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


class Test extends StatefulWidget {
  int min, max, count;
  Test({this.min = 5, this.max = 25, this.count = 9});
  @override
  _TestState createState() => _TestState(min: min, max: max, count: count);
}

class _TestState extends State<Test> {
  int min, max, count;
  _TestState({this.min = 10, this.max = 25, this.count = 9}); //Actualyy this initialization dosent matter
  TextEditingController _controller1, _controller2;
  int random_index_multiplicand;
  int random_index_multiplier;
  int ans, op1, op2, op3;
  int option_no = 0;
  int marks = 0;
  List options = [];
  List multiplicand;
  List multiplier;
  Random random = new Random();
  List<Color> colors = [];
  Color right, wrong;
  String error_msg;
  Color error_msg_color;
  bool _isButtonDisabled;
  List wrong_error_msgs = [
    "Try again",
    "Aww you were so close",
    "Don't worry you can do it!"
  ];
  List right_error_msgs = [
    "Yess you did it!",
    "Woah you are a expert",
    "Well done!",
    "You are killing it"
  ];
  List new_option_msgs = [
    "Now try this one! 😏",
    "Let's see if you can do this",
    "Try this one!",
    "Hmm, now try this one"
  ];
  bool enable_op = true;

  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    error_msg = "Okay let's start !";
    my_init_state();
    soundeffect(2);
  }

  void my_init_state() {
    print("min $min, max$max, count$count");

    multiplicand = [for (int i = min; i <= max; i++) i];
    multiplier = [for (int i = 2; i <= 10; i++) i];
    print("Multiplicandd is  $multiplicand");

    _isButtonDisabled = false;
    if (option_no <= count) {
      error_msg_color = Colors.green;
      option_no += 1;

      random_index_multiplicand = random.nextInt(multiplicand.length);
      random_index_multiplier = random.nextInt(multiplier.length);
      ans = multiplicand[random_index_multiplicand] *
          multiplier[random_index_multiplier];

      op1 = ans - random.nextInt(15);
      op2 = ans - random.nextInt(15);
      op3 = ans - random.nextInt(15);
      while (op1 == op2 ||
          op1 == op3 ||
          op2 == op3 ||
          op1 == ans ||
          op2 == ans ||
          op3 == ans) {
        op1 = ans - random.nextInt(15);
        op2 = ans - random.nextInt(15);
        op3 = ans - random.nextInt(15);
      }
      print("This is the random numberssss");
      print(ans - op1);
      print(ans - op2);
      print(ans - op3);

      options = [ans, op1, op2, op3]; //creating option list
      options.shuffle(); //shuffling option list
      print("hereeeeeee are the oooopptttttiiiiiiiiioooooooonssssssss");
      print(options); //printing list to the console
      print("Here is the answer: $ans");

      right = Colors.lightGreenAccent;
      wrong = Colors.redAccent;
      colors = [
        Colors.pink[100],
        Colors.pink[100],
        Colors.pink[100],
        Colors.pink[100],
      ];
    } else {
      print("Here are the marks;");
      print(marks);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Score_card(
                    marks: marks, count: count + 1, // program counts from 0
                    min: min, max: max,
                  )));
    }
  }

  void change_optins() {
    //this will be called only if option is right
    setState(() {
      int n = random.nextInt(right_error_msgs.length);
      error_msg = right_error_msgs[n];
      error_msg_color = Colors.green;
      marks += 1;
    });
    _isButtonDisabled = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        int n = random.nextInt(new_option_msgs.length);
        error_msg = new_option_msgs[n];
        my_init_state();
      });
    });
  }

  void change_wrong_color() {
    //this will be called only if option is wrong
    setState(() {
      int n = random.nextInt(wrong_error_msgs.length);
      error_msg = wrong_error_msgs[n];
      error_msg_color = Colors.red[400];
    });
    _isButtonDisabled = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        int n = random.nextInt(new_option_msgs.length);
        error_msg = new_option_msgs[n];
        my_init_state();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Question No $option_no"),
          backgroundColor: Colors.pinkAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                _settings_menu(context, min, max, count);
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "  Let's test how much you know (ᵔᴥᵔ)",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${multiplicand[random_index_multiplicand]} x ${multiplier[random_index_multiplier]} =",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$error_msg",
                    style: TextStyle(
                      color: error_msg_color,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //This is the test options
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Optionbutton(0)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Optionbutton(1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          //Option for test
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Optionbutton(2)),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Optionbutton(3)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
  void soundeffect(int choice){
//    0 = wrong
//    1 = right
//    2 = start
  if (choice == 1){
    assetsAudioPlayer.open(
      Audio("assets/correct1.mp3"),
    );
//              assetsAudioPlayer.seek(Duration(seconds: 1));
    Future.delayed(const Duration(seconds: 1), () {
      assetsAudioPlayer.stop();
    });
  }
  else if (choice == 0){
//    assetsAudioPlayer.open(Audio("assets/Wrong2.mp3"));
//    assetsAudioPlayer.seekBy(Duration(microseconds: 50));
//    assetsAudioPlayer.setVolume(0.5);
  }
  else{
    assetsAudioPlayer.open(Audio("assets/Start.mp3"));
  }
  }

  Widget Optionbutton(int buttonNo) {
    //buttonNo starts from 0
    return RaisedButton(
      child: Text(
        "${options[buttonNo]}",
        style: TextStyle(fontSize: 25),
      ),
      color: colors[buttonNo],
      onPressed: () {
        if (_isButtonDisabled == false) {
          setState(() {
            if (options[buttonNo] == ans) {
              colors[buttonNo] = right;
              soundeffect(1);
              change_optins();
            } else {
              colors[buttonNo] = wrong;
              soundeffect(0);
              change_wrong_color();
            }
          });
        } else {
          return null;
        }
      },
    );
  }
}


Future<void> _settings_menu(
    BuildContext context, int min, int max, int count) async {
  TextEditingController _controller1 =
      TextEditingController(text: min.toString());
  TextEditingController _controller2 =
      TextEditingController(text: max.toString());
  TextEditingController _controller3 = TextEditingController(
      text: (count + 1).toString()); // count is actualno + 1
  String new_min, new_max, new_count;
  new_min = min.toString();
  new_max = max.toString();
  new_count = count.toString();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 24.0,
        title: Text('Settings'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Min Table:     "),
                  Container(
                      height: 30,
                      width: 60,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        controller: _controller1,
                        onChanged: (str) {
                          new_min = str;
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Max Table:    "),
                  Container(
                      height: 30,
                      width: 60,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        controller: _controller2,
                        onChanged: (str) {
                          new_max = str;
                        },
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("No. of Questions: "),
                  Container(
                      height: 30,
                      width: 60,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        controller: _controller3,
                        onChanged: (str) {
                          new_count = str;
                        },
                      ))
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: () {
              if (new_min != min.toString() ||
                  new_max != max.toString() ||
                  new_count != count.toString()) {
                int nmin = int.parse(new_min);
                int nmax = int.parse(new_max);
                int ncount = int.parse(new_count);
                print(
                    "EEEEEEEEEExxxxxxxxxxxeeeeeeeccccccccccuuuuuuuutttttttteeeeeeeddddddddddd");
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Test(
                              min: nmin <= nmax ? nmin : nmax,
                              max: nmin >= nmax ? nmin : nmax,
                              count: ncount - 1,
                            )));
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text("Okay"),
          )
        ],
      );
    },
  );
}
