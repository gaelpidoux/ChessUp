import 'package:chess/chess.dart' as chess;

class BuffEffect {
  bool doubleAdvance = false;
  bool disableKnight = false;
  int turnCounter = 0;

  void onTurnPlayed(String fen) {
    final game = chess.Chess.fromFEN(fen);
    turnCounter++;

    doubleAdvance = turnCounter % 5 == 0;
    disableKnight = turnCounter % 7 == 0;
  }

  bool isDoubleAdvanceAvailable() => doubleAdvance;
  bool isKnightDisabled() => disableKnight;
}
