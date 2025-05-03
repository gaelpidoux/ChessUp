
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_chess_board/flutter_chess_board.dart';
import '../service/stockfish_service.dart';

class AIGamePage extends StatefulWidget {
  const AIGamePage({super.key});

  @override
  State<AIGamePage> createState() => _AIGamePageState();
}

class _AIGamePageState extends State<AIGamePage> {
  final ChessBoardController _controller = ChessBoardController();
  final StockfishService _stockfishService = StockfishService();

  @override
  void initState() {
    super.initState();
    _stockfishService.start();
  }

  void onMove() async {
    final fen = _controller.getFen();
    final bestMove = await _stockfishService.getBestMove(fen);
    if (bestMove != null && bestMove.length >= 4) {
      final from = bestMove.substring(0, 2);
      final to = bestMove.substring(2, 4);
      _controller.makeMove(from: from, to: to);
    }
  }

  @override
  void dispose() {
    _stockfishService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mat.Color(0xFF2E1B47),
      appBar: AppBar(
        title: const Text("Combat contre l'IA"),
        backgroundColor: mat.Color(0xFF1E1433),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChessBoard(
            controller: _controller,
            boardColor: BoardColor.brown,
            arrows: [],
            onMove: onMove,
          ),
        ],
      ),
    );
  }
}