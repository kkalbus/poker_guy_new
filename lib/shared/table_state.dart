enum TableState {
  waiting_to_start,  // 0
  // what to do next
  drawHighCard,      // 1
  shuffle,           // 2
  dealHole,          // 3
  dealFlop,          // 4
  dealTurn,          // 5
  dealRiver,         // 6
  doneDeal,          // 7
  closed             // 8
}
