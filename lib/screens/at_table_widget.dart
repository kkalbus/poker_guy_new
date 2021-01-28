import "package:flutter/material.dart";
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/models/table_player_names.dart';
import 'package:poker_guy/widgets/board_widget.dart';
import 'package:poker_guy/widgets/dealer_widget.dart';
import 'package:poker_guy/widgets/folded_widget.dart';
import 'package:poker_guy/widgets/header_playing_widget.dart';
import 'package:poker_guy/widgets/high_card_widget.dart';
import 'package:poker_guy/widgets/holecards_widget.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/shared/table_state.dart';
import 'package:provider/provider.dart';

class AtTableWidget extends StatefulWidget {
  static AppUser appUser = new AppUser(uid: "");
  @override
  _AtTableWidgetState createState() => _AtTableWidgetState();
}

class _AtTableWidgetState extends State<AtTableWidget> {
  @override
  Widget build(BuildContext context) {
    AtTableWidget.appUser = Provider.of<AppUser>(context);
    PokerTable table = Provider.of<PokerTable>(context);

    if(table == null) {
      return Container();
    }

    if (table.tableState != TableState.drawHighCard) {
      return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HeaderPlayingWidget(),
            BoardWidget(),
            AtTableWidget.appUser.folded ? FoldedWidget() : HoleCardsWidget(),
          ]);
    } else {
      return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HeaderPlayingWidget(),
            //BoardWidget(),

            AtTableWidget.appUser.isDealer ? DealerWidget() : Container(),
            HighCardWidget(),
          ]);
    }
    // );
  }
}
