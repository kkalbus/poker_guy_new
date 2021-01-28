import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/shared/constants.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/widgets/header_starting_widget.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/services/cloud_functions.dart';

class JoinTableWidget extends StatefulWidget {
  @override
  _JoinTableWidgetState createState() => _JoinTableWidgetState();
}

class _JoinTableWidgetState extends State<JoinTableWidget> {
  final _formKey = GlobalKey<FormState>();
  String nickname = "";
  String passphrase = "";
  var _nicknameController;
  var _passphraseController;
  String appUserNickname = "";
  String errMsg = "";

  @override
  Widget build(BuildContext context) {
    AppUser appUser = Provider.of<AppUser>(context);
    if (appUser == null) {
      // New guy. He won't have a nickname yet
      appUser = new AppUser(uid: appUser.uid);
    }

    nickname = appUser.nickname;
    bool tableNotFound = appUser.tableId == "Nope";

    if (tableNotFound) {
      errMsg = "Table Not Found - try again.";
    } else {
      errMsg = "";
    }

    _nicknameController = TextEditingController(text: nickname);
    _passphraseController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderStartingWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              color: Colors.green[300],
              onPressed: () {
                // Send user back to start screen
                appUser.setPlayerState(PlayerState.idle);
              },
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _nicknameController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Your nickname sir?'),
                      validator: (val) {
                        if (val == null) {
                          return null;
                        }
                        return (val.isEmpty
                            ? 'Please enter your nickname'
                            : null);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passphraseController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Table passphrase?'),
                      validator: (val) {
                        if (val == null) {
                          return null;
                        }
                        return (val.isEmpty
                            ? 'Please enter table passphrase'
                            : null);
                      },
                    ),
                    tableNotFound
                        ? Container(
                            child: Center(
                              child: Text(
                                errMsg,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Colors.green[900] ?? new Color(1))),
                        color: Colors.green[300],
                        child: Text(
                          "Join",
                          style: pgButtonTextDecoration,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: () async {
                          nickname = _nicknameController.text;
                          passphrase = _passphraseController.text;

                          // Update the users nickname if it has changed
                          if (appUser.nickname != nickname) {
                            appUser.nickname = nickname;
                            DatabaseService(uid: appUser.uid)
                                .updateAppUser(appUser);
                          }

                          cf_joinTable(appUser.uid, passphrase, appUser.nickname);
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
