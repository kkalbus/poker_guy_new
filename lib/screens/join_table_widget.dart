import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/shared/constants.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/widgets/header_starting_widget.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/services/cloud_functions.dart';
import 'package:sizer/sizer.dart';

class JoinTableWidget extends StatefulWidget {
  @override
  _JoinTableWidgetState createState() => _JoinTableWidgetState();
}

class _JoinTableWidgetState extends State<JoinTableWidget> {
  final _formKey = GlobalKey<FormState>();
  String passphrase = "";
  var _passphraseController;
  String errMsg = "";

  @override
  Widget build(BuildContext context) {
    AppUser appUser = Provider.of<AppUser>(context);
    if (appUser == null) {
      // New guy. He won't have a nickname yet
      appUser = new AppUser(uid: appUser.uid);
    }

    bool tableNotFound = appUser.tableId == "Nope";

    if (tableNotFound) {
      errMsg = "Table Not Found - try again.";
    } else {
      errMsg = "";
    }
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
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0.w),
          child: Form(
            key: _formKey,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Enter table passphrase:",
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 3.0.h,),
                    TextFormField(
                      controller: _passphraseController,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                      ),
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
                                  fontSize: 12.0.sp,
                                  color: Colors.red,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(4.0.w, 5.0.h, 4.0.h, 4.0.w),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0.h),
                            side: BorderSide(
                                color: Colors.green[900] ?? new Color(1))),
                        color: Colors.green[300],
                        child: Text(
                          "Join",
                            style: TextStyle(fontSize: 12.0.sp)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 1.0.h),
                        onPressed: () async {
                           passphrase = _passphraseController.text;
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
