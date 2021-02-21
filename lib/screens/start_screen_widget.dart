import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/services/auth.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/shared/constants.dart';
import 'package:poker_guy/shared/loading.dart';
import 'package:poker_guy/widgets/header_starting_widget.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/services/cloud_functions.dart';
import 'package:sizer/sizer.dart';

class StartScreenWidget extends StatefulWidget {
  @override
  _StartScreenWidgetState createState() => _StartScreenWidgetState();
}

class _StartScreenWidgetState extends State<StartScreenWidget> {
  final AuthService _auth1 = AuthService();
  String nickname = "";
  var _nicknameController;
  String error_str = "";
  bool isError = false;
  AppUser appUser;

  @override
  Widget build(BuildContext context) {
    appUser = Provider.of<AppUser>(context);
    if (appUser == null) {
      nickname = "";
      isError = false;
      error_str = "";
      return new Loading();
    }

    nickname = appUser.nickname;
    _nicknameController = TextEditingController(text: nickname);
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
          Widget>[
        HeaderStartingWidget(),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0.h, 7.0.h, 0.0, 2.0.h),
          child: AutoSizeText("Enter nickname:",
              style: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.h),
          child: TextFormField(
            controller: _nicknameController,
            onFieldSubmitted: (value) {
              checkNickname(0);
            },
            style: TextStyle(
              fontSize: 14.0.sp,
            ),
            decoration:
                textInputDecoration.copyWith(hintText: 'Your nickname sir?'),
          ),
        ),
        //  ],
        //  ),
        Center(
          child: !isError
              ? SizedBox(
                  height: 4.0.h,
                )
              : Container(
                  // margin: const EdgeInsets.all(30.0),
                  padding: EdgeInsets.all(1.0.h),

                  decoration: BoxDecoration(
                      border: Border.all(width: 1), color: Colors.yellow[500]),
                  child: Text(error_str,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.red[800],
                        //backgroundColor: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      )),
                ),
        ),
        Padding(
          padding: EdgeInsets.all(3.0.h),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0.h),
                      side:
                          BorderSide(color: Colors.green[900] ?? new Color(1))),
                  color: Colors.green[300],
                  child: Text("New Table", style: TextStyle(fontSize: 12.0.sp)),
                  onPressed: () => checkNickname(1),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0.h),
                      side:
                          BorderSide(color: Colors.green[900] ?? new Color(1))),
                  color: Colors.green[300],
                  child:
                      Text("Join Table", style: TextStyle(fontSize: 12.0.sp)),
                  onPressed: () => checkNickname(2),
                ),
              ]),
        ),
      ]),
    );
  }

  Future<void> checkNickname(int mode) async {
    // mode = 1 => start new table
    // mode = 2 => joining table

    isError = false;
    nickname = _nicknameController.text;
    if (nickname == "") {
      isError = true;

      if (mode == 0) {
        // the guy just used the enter key to
        // put in an empty nickname, so just reset
        // it to what it was before without an
        // error message
        return;
      }
      setState(() {
        error_str = "Please enter nickname!";
      });
    }

    if (isError) {
      // go back and wait for the user to enter
      // a valid nickname
      return;
    }
    // user has valid nickname
    isError = false;

    // Update the users nickname if it has changed
    if (appUser.nickname != nickname) {
      appUser.nickname = nickname;
      DatabaseService(uid: appUser.uid).updateAppUser(appUser);
    }

    if (mode == 1) {
      // Call the function to start a new table. If successful,
      // the function will set the playerState to "start table"
      // and to display the StartTableWidget.
      cf_openTable(appUser.uid, appUser.nickname);

      print ("after cf_opentable");
    } else if (mode == 2) {
      // This triggers the PokerGuyBodyWidget to display the
      // JoinTableWidget
      appUser.setPlayerState(PlayerState.joiningTable);
    }
  }
}
