import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/models/hole_cards.dart';
import 'package:poker_guy/widgets/header_playing_widget.dart';
import 'package:poker_guy/screens/poker_guy_body.dart';
import 'package:poker_guy/shared/loading.dart';
import 'package:poker_guy/main.dart';
import 'package:provider/provider.dart';
import 'package:poker_guy/services/database.dart';

class BigWidget extends StatefulWidget {
  @override
  _BigWidgetState createState() => _BigWidgetState();
}

class _BigWidgetState extends State<BigWidget> {
  @override
  Widget build(BuildContext context) {

    MyApp.screenSize = MediaQuery.of(context).size;
    MyApp.screenWidth = MyApp.screenSize.width;
    MyApp.screenHeight = MyApp.screenSize.height;

    // We need the user in order to set the DatabaseService uid,
    // which we need to get the AppUser

    User user = Provider.of<User>(context);
    if (user == null) {
      return Loading();
    }
  String uid = user.uid;
    return MultiProvider(
      providers: [
        StreamProvider<AppUser>.value(
            value: DatabaseService(uid: uid).appUser),
        StreamProvider<HoleCards>.value(
            value: DatabaseService(uid: user.uid).holeCards),
      ],
      child: SafeArea(
        child: Scaffold(
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/table_felt.jpg'),
                  fit: BoxFit.cover,
                )),
                child: PokerGuyBody(),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //       color: Colors.lightBlue,
            //       child: Center(child: Text("Banner Ad"))),
            // ),
          ]),
        ),
      ),
    );
  }
}
