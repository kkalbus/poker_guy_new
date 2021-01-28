import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/models/table_player_names.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/shared/constants.dart';
import 'package:poker_guy/shared/loading.dart';
import 'package:provider/provider.dart';

class PlayerList extends StatefulWidget {
  final List<dynamic> playerNames = [];
  // const PlayerList({Key key, this.playerNames}) : super(key: key);

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  //List<String> players = ["Player 33333", "Player 3", "Player 5"];
  @override
  Widget build(BuildContext context) {
    TablePlayerNames tablePlayers = Provider.of<TablePlayerNames>(context);
    if (tablePlayers == null) {
      return Container();
    }
  //  List<dynamic> playerNames = table.tablePlayers;
  //   if (tablePlayerNames == null) {
  //     tablePlayerNames = new List<String>();;
  //     return Container();
  //   }

    return Expanded(
      child: Column(children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        AutoSizeText(
          "Players:",
          style: textDecoration.copyWith(
              color: Colors.yellow,
              fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: tablePlayers.playerNames.length,
          //shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Center(
                child: AutoSizeText(

                  tablePlayers.playerNames[index],
                  style: textDecoration.copyWith(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
