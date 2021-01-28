import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/shared/table_state.dart';

FirebaseFunctions functions = FirebaseFunctions.instance;
final origin =
    Platform.isAndroid ? 'http://10.0.2.2:5001' : 'http://localhost:5001';

Future<void> cf_startTable(String tableId) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('startTable');
  final results = await callable({"tableId": tableId});
}

Future<void> cf_endHand(String tableId) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('endHand');
  var result = await callable({"tableId": tableId});
}

Future<void> cf_openTable(String uid, String nickname) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('openTable');
  //var result = await callable({"uid": uid, "nickname" : nickname});
  try {
    final HttpsCallableResult result = await callable({"uid": uid, "nickname" : nickname});
    print(result.data);
  } on CloudFunctionsException catch (e) {
    print('caught firebase functions exception');
    print(e.code);
    print(e.message);
    print(e.details);
  } on PlatformException catch (e) {
    print(e.message);
    print(e.details);
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

// ignore: non_constant_identifier_names
Future<void> cf_joinTable(String uid, String passphrase, String nickname) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('joinTable');
  final results = await callable({"uid": uid, "passphrase": passphrase, "nickname": nickname});
}

// ignore: non_constant_identifier_names
Future<void> cf_playerFolded(String uid, String tableId) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('playerFolded');
  final results = await callable({"uid": uid, "tableId": tableId});
}

Future<void> cf_drawHighCard(String tableId, String uid) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('drawHighCard');
  final results = await callable({"tableId": tableId, "uid": uid});
}

Future<void> cf_closeTable(String tableId) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('closeTable');
  var result = await callable({"tableId": tableId});
}

Future<void> cf_shuffleDeck(String tableId) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('shuffleDeck');
  var result = await callable({"tableId": tableId});
}

Future<void> cf_leaveTable(String uid, String tableId) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('leaveTable');
  var result = await callable({"uid": uid, "tableId": tableId});
}

Future<void> cf_dealHoleCards(String tableId) async {

  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('dealHoleCards');
  final result = await callable({"tableId": tableId});
}

Future<void> cf_dealBoardCards(PokerTable table) async {

  // Deal 3 cards if it's the flop otherwise 1.

  int numCards = table.tableState == TableState.dealFlop  ? 3 : 1;

  // the cloud function is going to set the table state
  // after it deals.
  int nextState = 5;
  if (table.tableState == TableState.dealTurn) {
    nextState = 6;
  } else if (table.tableState == TableState.dealRiver) {
    nextState = 7;
  }
  functions.useFunctionsEmulator(origin: origin);
  HttpsCallable callable = functions.httpsCallable('dealBoardCards');
  final result = await callable({"tableId": table.tableId,
  "numCards": numCards,
  "nextState" : nextState});
}