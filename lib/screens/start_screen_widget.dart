import 'package:flutter/material.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/services/auth.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/shared/constants.dart';
import 'package:poker_guy/widgets/header_starting_widget.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/services/cloud_functions.dart';

class StartScreenWidget extends StatefulWidget {
  @override
  _StartScreenWidgetState createState() => _StartScreenWidgetState();
}

class _StartScreenWidgetState extends State<StartScreenWidget> {
  final AuthService _auth1 = AuthService();
  String nickname = "";
  var _nicknameController;

  @override
  Widget build(BuildContext context) {
    AppUser appUser = Provider.of<AppUser>(context);
    if (appUser == null) {
      // New guy. He won't have a nickname yet
      appUser = new AppUser(uid: appUser.uid);
    }
    nickname = appUser.nickname;
    _nicknameController = TextEditingController(text: nickname);
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HeaderStartingWidget(),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            // Text("Enter nickname:",
            //     style: TextStyle(
            //       fontSize: 14,
            //       color: Colors.yellow,
            //       fontWeight: FontWeight.bold,
            //     )),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 10.0),
              child: Text("Enter nickname:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: _nicknameController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Your nickname sir?'),
                validator: (val) {
                  if (val == null) {
                    return null;
                  }
                  return (val.isEmpty ? 'Please enter your nickname' : null);
                },
              ),
            ),
            //  ],
            //  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Colors.green[900] ?? new Color(1))),
                        color: Colors.green[300],
                        child: Text("New Table"),
                        onPressed: () {
                          nickname = _nicknameController.text;

                          // Update the users nickname if it has changed
                          if (appUser.nickname != nickname) {
                            appUser.nickname = nickname;
                            DatabaseService(uid: appUser.uid)
                                .updateAppUser(appUser);
                          }

                          // Call the function to start a new table. If successful,
                          // the function will set the playerState to "start table"
                          // and to display the StartTableWidget.
                          cf_openTable(appUser.uid, appUser.nickname);
                        }),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Colors.green[900] ?? new Color(1))),
                        color: Colors.green[300],
                        child: Text("Join Table"),
                        onPressed: () {
                          nickname = _nicknameController.text;

                          // Update the users nickname if it has changed
                          if (appUser.nickname != nickname) {
                            appUser.nickname = nickname;
                            DatabaseService(uid: appUser.uid)
                                .updateAppUser(appUser);
                          }

                          // This triggers the PokerGuyWidget to display the
                          // JoinTableWidget
                          appUser.setPlayerState(PlayerState.joiningTable);
                        }),
                  ]),
            ),
          ]),
    );
  }
}
