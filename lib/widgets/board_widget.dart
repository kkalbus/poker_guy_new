import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poker_guy/shared/table_state.dart';
import 'package:poker_guy/screens/at_table_widget.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/models/poker_table.dart';

import 'dealer_widget.dart';

class BoardWidget extends StatefulWidget {
  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {

  //static PokerTable pokerTable ??;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    //AppUser appUser = Provider.of<AppUser>(context);
    PokerTable pokerTable = Provider.of<PokerTable>(context);

    if (pokerTable == null) {
      return Container();
    }



    List<dynamic> board = [];
    if (pokerTable != null) {
      board = pokerTable.board;
    }

    List<Widget> childrens = [];

    // Make sure the board space is there even if there are no
    // cards in it yet.
    childrens.add(new SizedBox(height:screenHeight * .15, width: 1));

    for (String card in board) {
      childrens.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SvgPicture.asset(
          "assets/cards/" + card + ".svg",
          width: screenWidth / 6,
        ),
      ));
    }
    return Container(
      color : Colors.transparent,
      child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            AtTableWidget.appUser.isDealer ? DealerWidget() : new Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: childrens.toList(),
              ),

            ),

          ]),
    );
  }
}
