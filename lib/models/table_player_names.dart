import 'package:cloud_firestore/cloud_firestore.dart';

class TablePlayerNames {

  List<String> playerNames;
  TablePlayerNames({this.playerNames});

  factory TablePlayerNames.fromSnapshots(QuerySnapshot snap) {

    List<String> playerNames = [];

    snap.docs.forEach((doc) {
      playerNames.add(doc["nickname"]);
    });

    return new TablePlayerNames(playerNames: playerNames);
  }

  // factory TablePlayerNames.fromMap(Map<String, dynamic> data1()) {
  //   Map<String, dynamic> data = data1() ?? {};
  //
  //   return TablePlayerNames(
  //       uid: data()['appUserId'] ?? '',
  //       nickname: data()['nickname'] ?? '',
  //       folded: data()['folded'] ?? true);
  // }
}