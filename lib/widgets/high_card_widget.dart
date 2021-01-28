import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/models/hole_cards.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/screens/at_table_widget.dart';
import 'package:poker_guy/services/cloud_functions.dart';
import 'package:poker_guy/main.dart';
import 'package:provider/provider.dart';

class HighCardWidget extends StatefulWidget {
  @override
  _HighCardWidgetState createState() => _HighCardWidgetState();
}

class _HighCardWidgetState extends State<HighCardWidget> {
  @override
  Widget build(BuildContext context) {
    PokerTable table = Provider.of<PokerTable>(context);
    HoleCards holeCards = Provider.of<HoleCards>(context);

    String card0 = holeCards.cardNames[0];
    if (holeCards == null ||
        holeCards.cardNames.length == 0 ||
        holeCards.cardNames[0] == null ||
        holeCards.cardNames[0] == "") {
      return Column(
        children: [
          Text("Draw for first deal:",
              style: TextStyle(
                fontSize: 22,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                  side: BorderSide(color: Colors.green[900] ?? new Color(1))),
              color: Colors.green[300],
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Draw Card",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              onPressed: () {
                cf_drawHighCard(
                    AtTableWidget.appUser.tableId, AtTableWidget.appUser.uid);
              },
            ),
          ),
        ],
      );
    } else {
      return Expanded(
        // child: Positioned(
        //   top: 30.0,
        //   left: 25.0,
        child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            width: MyApp.screenWidth / 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: Text("High card gets dealer button first. If its a tie, toss a coin. \n\nIf you " +
                            "are the designated dealer, press 'Shuffle' to start first hand.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          Positioned(
            top: MyApp.screenHeight / 5,
           // left: MyApp.screenWidth / 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/cards/" + holeCards.cardNames[0] + ".svg",
                //width: MyApp.screenWidth / 1,
                height: MyApp.screenHeight / 1.7,
              ),
            ),
          ),
        ]),
        // ),
      );
    }
  }
}
