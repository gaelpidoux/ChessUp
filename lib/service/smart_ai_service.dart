import 'dart:math';
import 'package:chess/chess.dart' as chess;
import '../service/buff_effect.dart';

class EvaluatedMove {
  final String from;
  final String to;
  final int score;

  EvaluatedMove(this.from, this.to, this.score);
}

class SmartChessAI {
  final _random = Random();

  int _pieceValue(String? piece) {
    switch (piece) {
      case 'p':
        return 1;
      case 'n':
      case 'b':
        return 3;
      case 'r':
        return 5;
      case 'q':
        return 9;
      default:
        return 0;
    }
  }

  String? getBestMove(String fen, {BuffEffect? buff}) {
    final game = chess.Chess.fromFEN(fen);
    final moves = game.generate_moves();

    final filteredMoves = moves.where((move) {
      if (buff?.isKnightDisabled() == true &&
          move.piece == 'n') {
        return false;
      }

      return true;
    }).toList();

    if (filteredMoves.isEmpty) return null;

    final evaluatedMoves = <EvaluatedMove>[];

    for (var move in filteredMoves) {
      final tempGame = chess.Chess.fromFEN(fen);
      tempGame.move(move);
      int score = 0;

      if (move.captured != null) {
        final captured = move.captured?.name.toLowerCase();
        score += _pieceValue(captured);
      }

      if (tempGame.in_checkmate) {
        score += 100;
      } else if (tempGame.in_check) {
        score += 3;
      }

      evaluatedMoves.add(EvaluatedMove(
        move.fromAlgebraic,
        move.toAlgebraic,
        score,
      ));
    }

    evaluatedMoves.sort((a, b) => b.score.compareTo(a.score));

    final best = evaluatedMoves.where((m) => m.score == evaluatedMoves.first.score).toList();
    final chosen = best[_random.nextInt(best.length)];

    return chosen.from + chosen.to;
  }
}
