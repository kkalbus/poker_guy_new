import 'package:cloud_firestore/cloud_firestore.dart';

class HoleCards {
  List<String> cardNames;

  HoleCards({ this.cardNames});

  factory HoleCards.fromMap(Map<String, dynamic> data()) {
    Map<String, dynamic> data1 = data() ?? {};

    List<String> cardNames = [];
    cardNames.add(data1['holeCard1']);
    cardNames.add(data1['holeCard2']);
    return HoleCards(cardNames: cardNames);
  }
}
