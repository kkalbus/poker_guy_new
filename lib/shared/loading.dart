import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: AutoSizeText("Poker Guy: LOADING"),
          backgroundColor: Colors.green[600],
          elevation: 0.0,
        ),
        body: Container(
          child: Center(
            child: Center(
              child: SpinKitChasingDots(
                color: Colors.green[600] ?? new Color(1),
                size: 150.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}