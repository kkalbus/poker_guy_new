import 'package:poker_guy/shared/table_state.dart';

class PokerTable {

  String tableId = ""; // same as tablePhrase except " " => "_".
  String tablePhrase = "";
  int handNumber = 0;
  bool shuffling = false;

  TableState tableState = TableState.waiting_to_start;
  List<dynamic> board = [];

  PokerTable (String tablePhrase) {
    this.tablePhrase = tablePhrase;
    this.tableId = tablePhrase.replaceAll(" ", "_");
  }

  Map<String, dynamic> toMap() {

    Map<String, dynamic> toReturn = new Map<String, dynamic>();
    toReturn['tableId'] = tableId;
    toReturn['tablePhrase'] = tablePhrase;
    toReturn['handNumber'] = handNumber;
    toReturn['board'] = board;
    toReturn['shuffling'] = shuffling;
    toReturn['tableState'] = tableState;

    return toReturn;
  }

  factory PokerTable.fromMap(Map<String, dynamic> data()) {

    if (data() == null) {
      return null;
    }

    Map<String, dynamic> data1 = data();
    PokerTable pt =  PokerTable(
        data1['tableId'] ?? ''
    );

    pt.tablePhrase = data1['tablePhrase'] ?? [];
    pt.tableState = TableState.values[data1['tableState']] ?? TableState.waiting_to_start;
    pt.board = data1['board'] ?? [];
    pt.shuffling = data1['shuffling'] ?? false;
    pt.handNumber = data1['handNumber'] ?? 0;
    return pt;
  }
}