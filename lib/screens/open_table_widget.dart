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
import 'package:sizer/sizer.dart';

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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          HeaderStartingWidget(),
          SizedBox(
            height: 5.0.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,

              children: [
                BackButton(
                  color: Colors.green[100],
                  onPressed: () {
                    // Send user back to start screen
                    appUser.setPlayerState(PlayerState.idle);
                    // Delete the table that he started
                    cf_deleteTable(table.tableId);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                AutoSizeText(
                  "Table Passphrase:",
                  style: textDecoration.copyWith(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0.sp),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 3.0.w, vertical: 1.0.h),
                  color: Colors.white,
                  child: AutoSizeText(
                    table.tablePhrase,
                    style: textDecoration.copyWith(
                        backgroundColor: Colors.white,
                        color: Colors.green[800],
                        fontSize: 22.0.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 2.0.h),
            child: Divider(
              color: Colors.green[900],
              height: 2.0.h,
              thickness: 5.0,
            ),
          ),
          PlayerList(),
          SizedBox(
            height: 4.0.h,
          ),
          Padding(
            padding: EdgeInsets.all(2.0.h),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0.h),
                  side: BorderSide(color: Colors.green[900] ?? new Color(1))),
              color: Colors.green[300],
              child: AutoSizeText(
                "Start Play",
                style: TextStyle(fontSize: 12.0.sp),
              ),
              padding: EdgeInsets.symmetric(vertical: 1.0.h),
              onPressed: () {
                appUser.isDealer = true;
                // assume that this user is also going to play
                appUser.playerState = PlayerState.atTable;
                DatabaseService(uid: appUser.uid).updateAppUser(appUser);
                cf_startTable(table.tableId);
                print ("after cf startTable");
              },
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
        ]);
  }
}
