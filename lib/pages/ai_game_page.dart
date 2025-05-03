import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import '../service/smart_ai_service.dart';

class AIGamePage extends StatefulWidget {
  const AIGamePage({super.key});

  @override
  State<AIGamePage> createState() => _AIGamePageState();
}

class _AIGamePageState extends State<AIGamePage> {
  final ChessBoardController _controller = ChessBoardController();
  final SmartChessAI _ai = SmartChessAI();

  void onMove() {
    final fen = _controller.getFen();
    final bestMove = _ai.getBestMove(fen);
    if (bestMove != null && bestMove.length >= 4) {
      final from = bestMove.substring(0, 2);
      final to = bestMove.substring(2, 4);
      Future.delayed(const Duration(milliseconds: 500), () {
        _controller.makeMove(from: from, to: to);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E1B47),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1433),
        title: const Text("Combat contre une IA locale"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChessBoard(
            controller: _controller,
            onMove: onMove,
            boardColor: BoardColor.brown,
          ),
        ],
      ),
    );
  }
}
