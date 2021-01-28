import 'package:flutter/material.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/services/cloud_functions.dart';
import 'package:poker_guy/shared/table_state.dart';
import 'package:provider/provider.dart';

class DealerWidget extends StatefulWidget {
  @override
  _DealerWidgetState createState() => _DealerWidgetState();
}

class _DealerWidgetState extends State<DealerWidget> {
  @override
  Widget build(BuildContext context) {
    PokerTable table = Provider.of<PokerTable>(context);
    bool doneDeal = table.tableState == TableState.doneDeal;
    List<Widget> _widgets = (table.tableState != TableState.shuffle) &&
        (table.tableState != TableState.drawHighCard)
        ? <Widget>[
            // call a function to get the Deal button if the board
            // is not yet full. If we are done dealing this round
            // we just want to see the "End Hand" button
            //
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green[900] ?? new Color(1))),
                color: doneDeal ? Colors.grey[300] : Colors.green[300],
                child: Text("Deal"),
                onPressed: doneDeal
                    ? null
                    : () {
                        if (table.tableState == TableState.dealHole) {
                          cf_dealHoleCards(table.tableId);
                        } else {
                          cf_dealBoardCards(table);
                        }
                      }),

            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green[900] ?? new Color(1))),
                color: Colors.green[300],
                child: Text("End Hand"),
                onPressed: () {
                  //DatabaseService().loadWordsToFirestore();
                  cf_endHand(table.tableId);
                }),
          ]
        : <Widget>[
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green[900] ?? new Color(1))),
                color: Colors.green[300],
                child: Text("Shuffle"),
                onPressed: () {
                  cf_shuffleDeck(table.tableId);
                }),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green[900] ?? new Color(1))),
                color: Colors.green[300],
                child: Text("Close Table"),
                onPressed: () {
                  cf_closeTable(table.tableId);
                }),
          ];
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        color: Colors.transparent,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: _widgets),
      ),
    );
  }
}
