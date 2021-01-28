import 'package:poker_guy/services/database.dart';

enum PlayerState {
  // Before player is at a table
  idle,               // 0
  openingTable,       // 1
  joiningTable,       // 2
  atTable             // 3
}

class AppUser {

  // This class represents a user/player of the app.

  bool folded = false;
  String uid;
  String nickname = "";
  String tableId;
  PlayerState playerState;
  bool isDealer = false;

  AppUser( {this.uid, this.nickname="", this.tableId="", this.playerState=PlayerState.idle, this.isDealer=false, this.folded=false});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toReturn = new Map<String, dynamic>();
    toReturn['nickname'] = nickname;
    toReturn['folded'] = folded;
    toReturn['isDealer'] = isDealer;
    toReturn['uid'] = uid;
    toReturn['tableId'] = tableId;
    toReturn['playerState'] = playerState.index;
    return toReturn;
  }

  factory AppUser.fromMap(Map<String, dynamic> data1()) {
    Map<String, dynamic> data = data1() ?? {};
    return AppUser(
        uid: data['uid'] ?? '',
        nickname: data['nickname'] ?? '',
        tableId: data['tableId'] ?? '',
        isDealer: data['isDealer'] ?? false,
        folded: data['folded'] ?? false,
        //playerState: data()['playerState'] ?? PlayerState.idle);
        playerState: PlayerState.values[data['playerState']] ?? PlayerState.idle);
  }

  void setPlayerState(PlayerState ps) {
    this.playerState = ps;

    DatabaseService(uid: this.uid).updateAppUser(this);
  }
}
