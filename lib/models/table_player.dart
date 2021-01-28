import 'package:firebase_auth/firebase_auth.dart';

import 'app_user.dart';

// This class represents a player from the PokerTable's POV.

class TablePlayer {
  // This class represents a user who has joined a table

  String uid;
  String nickname;
  bool folded;

  TablePlayer({this.uid, this.nickname, this.folded});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toReturn = new Map<String, dynamic>();
    toReturn['uid'] = uid;
    toReturn['nickname'] = nickname;
    toReturn['folded'] = folded;
    return toReturn;
  }

  factory TablePlayer.fromMap(Map<String, dynamic> data1()) {
    Map<String, dynamic> data = data1() ?? {};
    return TablePlayer(
        uid: data['appUserId'] ?? '',
        nickname: data['nickname'] ?? '',
        folded: data['folded'] ?? true);
  }
}
