import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("PokerGuy"),
          backgroundColor: Colors.green[600],
          elevation: 0.0,
        ),
        body: PokerGuyBody(),
      ),
    );
  }
}

class PokerGuyBody extends StatefulWidget {
  @override
  _PokerGuyBodyState createState() => _PokerGuyBodyState();
}

class _PokerGuyBodyState extends State<PokerGuyBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Text("Test1"),
              color: Colors.red,
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Text("Test2"),
              color: Colors.green,
            ),
          ),
          Expanded(
            flex:2,
            child: Container(
              child: Text("Test3"),
              color: Colors.yellow,
            ),
          )
        ]
    );
  }
}
