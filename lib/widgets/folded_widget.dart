import 'package:flutter/material.dart';
import 'package:poker_guy/main.dart';
import 'package:poker_guy/services/cloud_functions.dart';
import 'dart:math';

import 'package:poker_guy/screens/at_table_widget.dart';

class FoldedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     double but_pad = MyApp.screenHeight / 4;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Transform(
            transform: Matrix4.rotationZ(pi),
            alignment: Alignment.center,
            child: Container(
              color: Colors.green[300],
             // color: Colors.transparent,
              child: Center(
                child: Text(
                  "Folded",
                  style: TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 48,
                      color: Colors.red),
                ),
              ),
            ),
          ),

          Container(
          color: Colors.transparent,
          height: but_pad,
          ),

          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green[900] ?? new Color(1))),
              color: Colors.green[300],
              child: Text("Leave Table"),
              onPressed: () {
                cf_leaveTable(AtTableWidget.appUser.uid, AtTableWidget.appUser.tableId);
              }),
        ],
      ),
    );
  }
}
