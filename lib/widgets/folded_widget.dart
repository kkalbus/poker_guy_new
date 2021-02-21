import 'package:flutter/material.dart';
import 'package:poker_guy/main.dart';
import 'package:poker_guy/services/cloud_functions.dart';
import 'package:poker_guy/shared/constants.dart';
import 'dart:math';
import 'package:sizer/sizer.dart';
import 'package:poker_guy/screens/at_table_widget.dart';

class FoldedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double but_pad = MyApp.screenHeight / 4;
    return Padding(
      padding: EdgeInsets.fromLTRB(4.0.w, 2.0.h, 3.0.w, 4.0.h),
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
                      fontSize: 40.0.sp,
                      color: Colors.red),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: but_pad,
          ),

          // Dealer cannot leave table - he would need to end the table
          AtTableWidget.appUser.isDealer ? new Container() : RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0.h),
                  side: BorderSide(color: Colors.green[900] ?? new Color(1))),
              color: Colors.green[300],
              child: Text("Leave Table", style: pgButtonTextDecoration),
              onPressed: () {
                cf_leaveTable(
                    AtTableWidget.appUser.uid, AtTableWidget.appUser.tableId);
              }),
        ],
      ),
    );
  }
}
