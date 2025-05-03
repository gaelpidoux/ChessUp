import 'dart:math';
import 'package:chess/chess.dart' as chess;

class SimpleChessAI {
  final _random = Random();

  String? getBestMove(String fen) {
    final game = chess.Chess.fromFEN(fen);
    final moves = game.generate_moves();

    if (moves.isEmpty) return null;
    final move = moves[_random.nextInt(moves.length)];
    return move.fromAlgebraic + move.toAlgebraic;
  }
}
