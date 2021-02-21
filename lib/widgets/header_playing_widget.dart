import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/shared/table_state.dart';
import 'package:poker_guy/screens/at_table_widget.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/services/database.dart';
import 'package:sizer/sizer.dart';

class HeaderPlayingWidget extends StatefulWidget {
  @override
  _HeaderPlayingWidgetState createState() => _HeaderPlayingWidgetState();
}

class _HeaderPlayingWidgetState extends State<HeaderPlayingWidget> {
  static var status = "";
  static var shuffling = false;
  static PokerTable table;

  @override
  Widget build(BuildContext context) {
    table = Provider.of<PokerTable>(context);
    if (table == null) {
      return Container();
    }
    String phrase = "";
    if (table != null) {
      phrase = table.tablePhrase;
    }

    if (table.shuffling) {
      shuffle_animation();

    } else {

      _HeaderPlayingWidgetState.status = "Waiting";
      if (table.tableState == TableState.dealHole) {
        _HeaderPlayingWidgetState.status = "Shuffled";
      } else if (table.tableState == TableState.dealFlop) {
        _HeaderPlayingWidgetState.status = "Pre-Flop";
      } else if (table.tableState == TableState.dealTurn) {
        _HeaderPlayingWidgetState.status = "Flop";
      } else if (table.tableState == TableState.dealRiver) {
        _HeaderPlayingWidgetState.status = "Turn";
      } else if (table.tableState == TableState.doneDeal) {
        _HeaderPlayingWidgetState.status = "River";
      }
    }

    String handNum = "";
    if (table != null) {
      handNum = "Hand : " + table.handNumber.toString();
    }

    String nickname = "";
    if (AtTableWidget.appUser != null) {
      nickname = AtTableWidget.appUser.nickname;
    }

    return Container(

      color: Colors.black,

      child: Column(children: [
        Divider(
          color: Colors.green[900],
          height: 2.0,
          thickness: 2.0,
        ),
        Padding(
          padding: EdgeInsets.all(1.0.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Table: " + phrase,
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    )),
                Text(_HeaderPlayingWidgetState.status,
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    )),
                Text(handNum,
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    )),
                Text(nickname,
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    )),
              ]),
        ),
      ]),
    );
  }

  void shuffle_animation() async {

    if (_HeaderPlayingWidgetState.shuffling) {
      return;
    }
    _HeaderPlayingWidgetState.shuffling = true;

    for (var i=0; i<100; i++) {
      _HeaderPlayingWidgetState.status = "Shuffling " + i.toString() + "%";

      setState(() {
      });

      // wait a bit
      await Future.delayed(Duration(milliseconds: 10));
    }
    _HeaderPlayingWidgetState.shuffling = false;
    String tableId = table.tableId;
    DatabaseService(tableId: tableId).shuffleOff();

  }
}
