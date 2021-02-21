import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:poker_guy/models/hole_cards.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/screens/at_table_widget.dart';
import 'package:poker_guy/shared/table_state.dart';
import 'package:poker_guy/widgets/high_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/services/cloud_functions.dart';
import 'package:poker_guy/main.dart';

class HoleCardsWidget extends StatefulWidget {
  static double opacity = 1;
  static bool peeking = false;

  @override
  _HoleCardsWidgetState createState() => _HoleCardsWidgetState();
}

class _HoleCardsWidgetState extends State<HoleCardsWidget> {
  double ptop = 30;
  double ptop1 = 80;
  bool folded = false;
  int dragDuration = 0;
  int dragDuration1 = 0;
  int opacityDuration = 0;
  double opacity1 = 1.0;

  @override
  Widget build(BuildContext context) {
    HoleCards holeCards = Provider.of<HoleCards>(context);
    PokerTable table = Provider.of<PokerTable>(context);

    if (table == null) {
      return Container();
    }

    if (holeCards == null ||
        holeCards.cardNames.length == 0 ||
        holeCards.cardNames[0] == null ||
        holeCards.cardNames[1] == null ||
        holeCards.cardNames[0] == "" ||
        holeCards.cardNames[1] == "") {
      opacity1 = 1;
      return Container();
    }
    double dragTotal = 0;
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          //***
          // Hole card 1, back hole, back full
          // opacity always = 1, unless folded
          Positioned(
            top: folded ? -1000.0 : 30.0,
            left: 25.0,
            child: SvgPicture.asset(
              "assets/cards/" + holeCards.cardNames[0] + ".svg",
              width: MyApp.screenWidth / 1,
              height: MyApp.screenHeight / 1,
            ),
          ),

          //**
          // card with hole always full on or full off
          Positioned(
            top: 28.0,
            left: 25.0,
            child: Opacity(
              opacity: folded ? 0 : opacity1,
              child: SvgPicture.asset(
                "assets/cards/red_back_hole.svg",
                width: MyApp.screenWidth / 1,
                height: MyApp.screenHeight / 1,
              ),
            ),
          ),

          //*** Full back card opacity can be animated
          AnimatedPositioned(
            onEnd: () {
              opacity1 = 1;
            },
            top: ptop,
            left: 25.0,
            duration: Duration(milliseconds: 600),
            child: AnimatedOpacity(
              opacity: HoleCardsWidget.peeking ? 0 : opacity1,
              duration: Duration(
                  milliseconds:
                      HoleCardsWidget.peeking ? 500 : opacityDuration),
              child: SvgPicture.asset(
                "assets/cards/red_back.svg",
                width: MyApp.screenWidth / 1,
                height: MyApp.screenHeight / 1,
              ),
            ),
          ),
          // ****
          // Hole card 2
          // ****
          Positioned(
            top: folded ? -1000.0 : 80.0, // send it to the cornfield if folded
            left: 120.0,
            child: SvgPicture.asset(
              "assets/cards/" + holeCards.cardNames[1] + ".svg",
              width: MyApp.screenWidth / 1,
              height: MyApp.screenHeight / 1,
            ),
          ),

          //*** card with hole - full on or full off
          Positioned(
            top: 78.0,
            left: 120.0,
            child: Opacity(
              opacity: folded ? 0 : opacity1,
              child: SvgPicture.asset(
                "assets/cards/red_back_hole.svg",
                width: MyApp.screenWidth / 1,
                height: MyApp.screenHeight / 1,
              ),
            ),
          ),

          //**** Full back card opacity can be animated
          AnimatedPositioned(
            onEnd: () {
              opacity1 = 1;
              cf_playerFolded(
                  AtTableWidget.appUser.uid, AtTableWidget.appUser.tableId);
            },
            top: ptop1,
            left: 120.0,
            duration: Duration(milliseconds: dragDuration1),
            child: AnimatedOpacity(
              opacity: HoleCardsWidget.peeking ? 0 : opacity1,
              duration: Duration(
                  milliseconds:
                      HoleCardsWidget.peeking ? 500 : opacityDuration),
              child: SvgPicture.asset(
                "assets/cards/red_back.svg",
                width: MyApp.screenWidth / 1,
                height: MyApp.screenHeight / 1,
              ),
            ),
          ),

          GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              setState(() {
                return opacity1 = (opacity1 - 1).abs();
              });
            },
            onLongPressStart: (details) {
              HoleCardsWidget.peeking = true;
              setState(() {});
            },
            onLongPressUp: () {
              HoleCardsWidget.peeking = false;
              setState(() {});
            },
            onVerticalDragUpdate: (var dragUpdateDetails) {
              double delta = dragUpdateDetails.primaryDelta;
              dragTotal += delta;
              print("dragTotal = " + dragTotal.toString());
              if (dragTotal < 0.0) {
                if (!folded) {
                  folded = true;
                }
              }

              if (dragTotal < -50) {
                ptop = -800;
                ptop1 = -800;
                dragDuration = 500;
                dragDuration1 = 300;
                opacityDuration = 500;
                opacity1 = 0;
                folded = true;
                setState(() {});
              }
            },
            onVerticalDragDown: (DragDownDetails dragDownDetails) {
              dragTotal = 0;
              folded = false;
            },
            onVerticalDragStart: (DragStartDetails dragStartDetails) {
              dragTotal = 0;
            },
            child: SizedBox(
                width: MyApp.screenWidth,
                height: MyApp.screenWidth / 4,
                child: Container(
                  color: Colors.transparent,
                )),
          )
        ]),
      ),
    );
  }
}
