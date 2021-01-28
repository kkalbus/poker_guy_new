import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/shared/table_state.dart';
import 'package:provider/provider.dart';

class HeaderStartingWidget extends StatefulWidget {
  @override
  _HeaderStartingWidgetState createState() => _HeaderStartingWidgetState();
}

class _HeaderStartingWidgetState extends State<HeaderStartingWidget> {
  static var status = "";
  static var shuffling = false;

  @override
  Widget build(BuildContext context) {

    AppUser player = Provider.of<AppUser>(context);
    String title = "Poker Guy : Start";
    if (player.playerState == PlayerState.openingTable) {
      title = "Poker Guy: New Table";
    } else if (player.playerState == PlayerState.joiningTable) {
      title = "Poker Guy: Join Table";
    }

    return Container(

      color: Colors.black,
      child: Column(children: [
        Divider(
          color: Colors.green[900],
          height: 2.0,
          thickness: 3.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    )),

              ]),
        ),
      ]),
    );
  }


}
