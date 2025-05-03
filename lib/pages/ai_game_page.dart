import 'package:flutter/material.dart' as mat;
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'dart:math';

import '../service/smart_ai_service.dart';
import 'package:chess/chess.dart' as ch;
import '../service/buff_effect.dart';

class AIGamePage extends mat.StatefulWidget {
  const AIGamePage({super.key});

  @override
  mat.State<AIGamePage> createState() => _AIGamePageState();
}

class _AIGamePageState extends mat.State<AIGamePage> {
  final ChessBoardController _controller = ChessBoardController();
  final SmartChessAI _ai = SmartChessAI();
  final BuffEffect _buffEffect = BuffEffect();

  final squares = [
    'a8','b8','c8','d8','e8','f8','g8','h8',
    'a7','b7','c7','d7','e7','f7','g7','h7',
    'a6','b6','c6','d6','e6','f6','g6','h6',
    'a5','b5','c5','d5','e5','f5','g5','h5',
    'a4','b4','c4','d4','e4','f4','g4','h4',
    'a3','b3','c3','d3','e3','f3','g3','h3',
    'a2','b2','c2','d2','e2','f2','g2','h2',
    'a1','b1','c1','d1','e1','f1','g1','h1',
  ];

  double _rotationAngle = 0.0;
  String _lastFen = '';
  bool _showPromotionMessage = false;
  bool _showRotationMessage = false;

  void onMove() {
    final currentFen = _controller.getFen();
    final previous = ch.Chess.fromFEN(_lastFen);
    final current = ch.Chess.fromFEN(currentFen);
    _lastFen = currentFen;

    _buffEffect.onTurnPlayed(currentFen);

    int countKnights(ch.Chess game) {
      int count = 0;
      for (var square in squares) {
        final piece = game.get(square);
        if (piece != null && piece.type == ch.PieceType.KNIGHT) {
          count++;
        }
      }
      return count;
    }


    final knightsBefore = countKnights(previous);
    final knightsAfter = countKnights(current);

    if (knightsAfter < knightsBefore) {
      setState(() {
        _rotationAngle += pi;
        _showRotationMessage = true;
      });
    }

    final sanMoves = _controller.getSan();
    final lastSan = sanMoves.isNotEmpty ? sanMoves.last ?? '' : '';
    final lastMoveWasPawnCapture = lastSan.contains('x') &&
        !lastSan.contains('K') &&
        !lastSan.contains('Q') &&
        !lastSan.contains('R') &&
        !lastSan.contains('B') &&
        !lastSan.contains('N');

    setState(() {
      _showPromotionMessage = lastMoveWasPawnCapture;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      final bestMove = _ai.getBestMove(currentFen, buff: _buffEffect);
      if (bestMove != null && bestMove.length >= 4) {
        _controller.makeMove(
          from: bestMove.substring(0, 2),
          to: bestMove.substring(2, 4),
        );
      }
    });
  }

  @override
  mat.Widget build(mat.BuildContext context) {
    return mat.Scaffold(
      backgroundColor: const mat.Color(0xFF2E1B47),
      appBar: mat.AppBar(
        backgroundColor: const mat.Color(0xFF1E1433),
        title: const mat.Text("Combat contre une IA locale"),
      ),
      body: mat.Stack(
        alignment: mat.Alignment.topCenter,
        children: [
          mat.Column(
            mainAxisAlignment: mat.MainAxisAlignment.center,
            children: [
              mat.Transform.rotate(
                angle: _rotationAngle,
                child: ChessBoard(
                  controller: _controller,
                  onMove: onMove,
                  boardColor: BoardColor.brown,
                ),
              ),
            ],
          ),
          if (_showRotationMessage)
            mat.Positioned(
              top: 20,
              child: mat.Container(
                padding: const mat.EdgeInsets.all(8),
                decoration: mat.BoxDecoration(
                  color: mat.Colors.deepPurpleAccent,
                  borderRadius: mat.BorderRadius.circular(8),
                ),
                child: const mat.Text(
                  "Un cavalier capturé ! Plateau inversé 🌀",
                  style: mat.TextStyle(color: mat.Colors.white),
                ),
              ),
            ),
          if (_showPromotionMessage)
            mat.Positioned(
              top: 60,
              child: mat.Container(
                padding: const mat.EdgeInsets.all(8),
                decoration: mat.BoxDecoration(
                  color: mat.Colors.amber,
                  borderRadius: mat.BorderRadius.circular(8),
                ),
                child: const mat.Text(
                  "Pion boosté ! 🎖",
                  style: mat.TextStyle(color: mat.Colors.black),
                ),
              ),
            ),
          if (_buffEffect.isDoubleAdvanceAvailable())
            mat.Positioned(
              top: 100,
              child: mat.Container(
                padding: const mat.EdgeInsets.all(8),
                decoration: mat.BoxDecoration(
                  color: mat.Colors.green,
                  borderRadius: mat.BorderRadius.circular(8),
                ),
                child: const mat.Text(
                  "Buff actif : Double avancement 💨",
                  style: mat.TextStyle(color: mat.Colors.white),
                ),
              ),
            ),
          if (_buffEffect.isKnightDisabled())
            mat.Positioned(
              top: 140,
              child: mat.Container(
                padding: const mat.EdgeInsets.all(8),
                decoration: mat.BoxDecoration(
                  color: mat.Colors.redAccent,
                  borderRadius: mat.BorderRadius.circular(8),
                ),
                child: const mat.Text(
                  "Débuff : Cavaliers désactivés ❌🐴",
                  style: mat.TextStyle(color: mat.Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
