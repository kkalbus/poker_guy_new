import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/shared/table_state.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/screens/at_table_widget.dart';

bool useFunctionEmulator = false;
FirebaseFunctions functions = FirebaseFunctions.instance;
final origin =
    Platform.isAndroid ? 'http://10.0.2.2:5001' : 'http://localhost:5001';

Future<void> cf_startTable(String tableId) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('startTable');

  try {
    await callable({"tableId": tableId}).then((res) {
      print(" ***** startTable " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

Future<void> cf_endHand(String tableId) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('endHand');

  try {
    await callable({"tableId": tableId}).then((res) {
      print(" ***** endHand took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

Future<void> cf_openTable(String uid, String nickname) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('openTable');

  try {
    callable({"uid": uid, "nickname": nickname}).then((res) {
      print(" ***** openTable took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

// ignore: non_constant_identifier_names
Future<void> cf_joinTable(
    String uid, String passphrase, String nickname) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('joinTable');
  try {
    await callable({"uid": uid, "passphrase": passphrase, "nickname": nickname}).then((res) {
      print(" ***** joinTable took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }

}

// ignore: non_constant_identifier_names
Future<void> cf_playerFolded(String uid, String tableId) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  // Have the player wipe out his hole cards and set his state himself
  // to save time.
  DatabaseService().playerFolds(AtTableWidget.appUser);

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('playerFolded');

  try {
    await callable({"uid": uid, "tableId": tableId}).then((res) {
      print(" ***** playerFolded took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

Future<void> cf_drawHighCard(String tableId, String uid) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('drawHighCard');

  try {
    await callable({"tableId": tableId, "uid": uid}).then((res) {
      print(" ***** drawHighCard took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

// Just marks the table closed. deleteTable wipes it out altogether.
Future<void> cf_closeTable(String tableId) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('closeTable');
  try {
    await callable({"tableId": tableId}).then((res) {
      print(" ***** closeTable took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

Future<void> cf_deleteTable(String tableId) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('deleteTable');
  try {
    await callable({"tableId": tableId}).then((res) {
      print(" ***** deleteTable took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

Future<void> cf_shuffleDeck(String tableId) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('shuffleDeck');

  try {
    await callable({"tableId": tableId}).then((res) {
      print(" ***** shuffleDeck took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

Future<void> cf_leaveTable(String uid, String tableId) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  // player resets himself, but still needs to have himself removed
  // from the table in cloud functions

  DatabaseService().leaveTable(AtTableWidget.appUser);
  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('leaveTable');
  try {
    await callable({"uid": uid, "tableId": tableId}).then((res) {
      print(" ***** leaveTable took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

Future<void> cf_dealHoleCards(String tableId) async {
  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('dealHoleCards');

  try {
    await callable({"tableId": tableId}).then((res) {
      print(" ***** dealHoleCards took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

Future<void> cf_dealBoardCards(PokerTable table) async {
  // Deal 3 cards if it's the flop otherwise 1.

  int numCards = table.tableState == TableState.dealFlop ? 3 : 1;

  // the cloud function is going to set the table state
  // after it deals.
  int nextState = 5;
  if (table.tableState == TableState.dealTurn) {
    nextState = 6;
  } else if (table.tableState == TableState.dealRiver) {
    nextState = 7;
  }

  useFunctionEmulator ? functions.useFunctionsEmulator(origin: origin) : {};

  Stopwatch watch = new Stopwatch();
  watch.start();
  HttpsCallable callable = functions.httpsCallable('dealBoardCards');

  try {
    await  callable(
      {"tableId": table.tableId, "numCards": numCards, "nextState": nextState}).then((res) {
      print(" ***** dealBoardCards took " + watch.elapsedMilliseconds.toString());
      print("**** return from cloud function: " + res.data);
    });
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}
