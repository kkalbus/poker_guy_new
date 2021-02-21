import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/shared/table_state.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HeaderStartingWidget extends StatefulWidget {
  @override
  _HeaderStartingWidgetState createState() => _HeaderStartingWidgetState();
}

class _HeaderStartingWidgetState extends State<HeaderStartingWidget> {
  @override
  Widget build(BuildContext context) {
    String title = "Poker Guy : Start";
    String nickname = "";

    AppUser player = Provider.of<AppUser>(context);

    if (player != null) {
      nickname = player.nickname;

      if (player.playerState == PlayerState.openingTable) {
        title = "Poker Guy: New Table";
      } else if (player.playerState == PlayerState.joiningTable) {
        title = "Poker Guy: Join Table";
      }
    }

    return Container(
      color: Colors.black,
      child: Column(children: [
        Divider(
          color: Colors.green[900],
          height: 2.0,
          thickness: 2.0,
        ),
        Padding(
          padding: EdgeInsets.all(1.0.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(title,
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    )),
                player != null
                    ? Text(nickname,
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ))
                    : Container(),

              ]),
        ),
      ]),
    );
  }
}
