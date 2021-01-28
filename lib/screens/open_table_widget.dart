import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/services/cloud_functions.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/shared/constants.dart';
import 'package:poker_guy/widgets/header_starting_widget.dart';
import 'package:poker_guy/widgets/player_list.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/models/app_user.dart';

class OpenTableWidget extends StatefulWidget {
  // final String tableId;
  // StartTableWidget({this.tableId});

  @override
  _OpenTableWidgetState createState() => _OpenTableWidgetState();
}

class _OpenTableWidgetState extends State<OpenTableWidget> {
  //By the time we build this widget we should have a valid tableId

  // @override
  Widget build(BuildContext context) {
    PokerTable table = Provider.of<PokerTable>(context);
    if (table == null) {
      return Container();
    }
    AppUser appUser = Provider.of<AppUser>(context);

    //By the time we build this widget we should have a valid tableId
    //joinTable(appUser.uid, table.tablePhrase, appUser.nickname);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeaderStartingWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                AutoSizeText(
                  "Table Passphrase:",
                  style: textDecoration.copyWith(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  color: Colors.white,
                  child: AutoSizeText(
                    table.tablePhrase,
                    style: textDecoration.copyWith(
                        backgroundColor: Colors.white,
                        color: Colors.green[800],
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(
              color: Colors.green[900],
              height: 30.0,
              thickness: 5.0,
            ),
          ),
          PlayerList(),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green[900] ?? new Color(1))),
              color: Colors.green[300],
              child: Text(
                "Start Play",
                style: pgButtonTextDecoration,
              ),
              padding: EdgeInsets.symmetric(vertical: 15.0),
              onPressed: () {
                appUser.isDealer = true;
                // assume that this user is also going to play
                appUser.playerState = PlayerState.atTable;
                DatabaseService(uid: appUser.uid).updateAppUser(appUser);
                cf_startTable(table.tableId);
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ]);
  }
}
