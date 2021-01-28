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
  //static bool folded = false;
  //static double ptop = -38;

  static var redBacksPeek = Image.asset(
    "assets/cards/red_backs_peek2.png",
    width: MyApp.screenWidth / 1,
    height: MyApp.screenHeight / 1,
  );

  static var redBacks = Image.asset(
    "assets/cards/red_backs2.png",
    width: MyApp.screenWidth / 1,
    height: MyApp.screenHeight / 1,
  );

  @override
  _HoleCardsWidgetState createState() => _HoleCardsWidgetState();
}

class _HoleCardsWidgetState extends State<HoleCardsWidget> {
  double ptop = -38;
  bool folded = false;

  @override
  Widget build(BuildContext context) {
    print("\n HoleCardsWidget build");
    HoleCards holeCards = Provider.of<HoleCards>(context);
    PokerTable table = Provider.of<PokerTable>(context);

    if (table == null) {
      return Container();
    }

    // if (HoleCardsWidget.opacity > 1) {
    //   HoleCardsWidget.opacity = 1;
    // } else if (HoleCardsWidget.opacity < 0) {
    //   HoleCardsWidget.opacity = 0;
    // }

    // if (table.tableState == TableState.drawHighCard) {
    //   return new HighCardWidget();
    // }

    if (holeCards == null ||
        holeCards.cardNames.length == 0 ||
        holeCards.cardNames[0] == null ||
        holeCards.cardNames[1] == null ||
        holeCards.cardNames[0] == "" ||
        holeCards.cardNames[1] == "") {
      HoleCardsWidget.opacity = 1;
      return Container();
    }

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () {
          print("ontap");
          setState(() =>
              HoleCardsWidget.opacity = (HoleCardsWidget.opacity - 1).abs());
        },
        onLongPressStart: (details) {
          //HoleCardsWidget._buttonPressed = true;
          HoleCardsWidget.peeking = true;
          print("long press start");
          setState(() {});
          //peek();
        },
        onLongPressUp: () {
          //HoleCardsWidget._buttonPressed = false;
          //HoleCardsWidget.opacity_peek = 1;
          HoleCardsWidget.peeking = false;
          print("long press up");
          setState(() {});
        },
        onVerticalDragEnd: (var dragEndDetails) {
          double v = dragEndDetails.primaryVelocity;
          if (v != null && v < 0) {
            print("vertical drag");
            setState(() {
              ptop = -400;
            });
            cf_playerFolded(
                AtTableWidget.appUser.uid, AtTableWidget.appUser.tableId);
          }
        },
        child: Container(
          color: Colors.transparent,
          //color: Colors.red,

          child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Positioned(
              top: 30.0,
              left: 25.0,
              child: SvgPicture.asset(
                "assets/cards/" + holeCards.cardNames[0] + ".svg",
                width: MyApp.screenWidth / 1,
                height: MyApp.screenHeight / 1,
              ),
            ),
            Positioned(
              top: 80.0,
              left: 120.0,
              child: SvgPicture.asset(
                "assets/cards/" + holeCards.cardNames[1] + ".svg",
                width: MyApp.screenWidth / 1,
                height: MyApp.screenHeight / 1,
              ),
            ),
            AnimatedPositioned(
              top: ptop, //HoleCardsWidget.folded ? -400 : -38.0,
              left: 25.0,
              duration:
                  Duration(milliseconds: 2500),
              child: AnimatedOpacity(
                opacity: HoleCardsWidget.peeking ? 0 : HoleCardsWidget.opacity,
                duration:
                    Duration(milliseconds: HoleCardsWidget.peeking ? 500 : 0),
                child: HoleCardsWidget.redBacks,
              ),
            ),
            Positioned(
              top: -38,
              left: 25.0,
              child: Opacity(
                opacity: HoleCardsWidget.opacity,
                child: HoleCardsWidget.redBacksPeek,
              ),
            ),
          ]),
          // ),
        ),
      ),
    );
  }

}
