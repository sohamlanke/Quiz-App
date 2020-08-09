import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  String number;
  TableScreen({Key key, @required this.number}) : super(key: key);
  @override
  _TableScreenState createState() => _TableScreenState(number);
}

class _TableScreenState extends State<TableScreen> {
  String number;
  List table = [];
  num shade = 100;
  List rainbow_colors = [Colors.redAccent[200],Colors.orangeAccent[200],Colors.yellowAccent[200],Colors.greenAccent[200],Colors.lightBlueAccent[200],
    Colors.indigoAccent[200],Colors.indigo[100]
  ,Colors.green[500],Colors.blue[500],Colors.green[400]];
  _TableScreenState(this.number);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    table = [for (int i = 1; i <= 10 ; i++) i* int.parse(number)];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Multiplication table of $number"),),
      body: ListView.builder(
        itemCount: table.length,
        itemBuilder: (context, index) {
          return Card(
            color: rainbow_colors[index],
            child: ListTile(
              title: Text('$number x ${index+1} = ${table[index]}',style: TextStyle(fontSize: 30,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),),
            ),
          );
        },
      ),
    );
  }
}
