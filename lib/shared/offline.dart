import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Offline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: AutoSizeText("Poker Guy: OFFLINE"),
          backgroundColor: Colors.green[600],
          elevation: 0.0,
        ),
        body: Container(
          child: Center(
            child: Text(
              "Poker Guy is offline.",
              style: textDecoration.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 35.0),
            ),
          ),
        ),
      ),
    );
  }
}
