import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/models/table_player_names.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/shared/constants.dart';
import 'package:poker_guy/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PlayerList extends StatefulWidget {
  final List<dynamic> playerNames = [];

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {

  @override
  Widget build(BuildContext context) {
    TablePlayerNames tablePlayers = Provider.of<TablePlayerNames>(context);
    if (tablePlayers == null) {
      return Container();
    }

    return Expanded(
      child: Column(children: <Widget>[
        SizedBox(
          height: 1.0.h,
        ),
        AutoSizeText(
          "Players:",
          style: textDecoration.copyWith(
              color: Colors.green[100],
              fontWeight: FontWeight.bold, fontSize: 20.0.sp),
        ),
        SizedBox(
          height: 1.0.h,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: tablePlayers.playerNames.length,
          //shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(0.5.h),
              child: Center(
                child: AutoSizeText(

                  tablePlayers.playerNames[index],
                  style: textDecoration.copyWith(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold, fontSize: 16.0.sp),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
