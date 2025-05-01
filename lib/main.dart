import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import '/service/stockfish_service.dart';

void main() {
  runApp(const ChessBuffsApp());
}

class ChessBuffsApp extends StatelessWidget {
  const ChessBuffsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess Buffs',
      home: const ChessGamePage(),
    );
  }
}

class ChessGamePage extends StatefulWidget {
  const ChessGamePage({super.key});

  @override
  State<ChessGamePage> createState() => _ChessGamePageState();
}

class _ChessGamePageState extends State<ChessGamePage> {
  final ChessBoardController _controller = ChessBoardController();
  final StockfishService _stockfishService = StockfishService();
  bool rotated = false;
  String previousFen = '';

  @override
  void initState() {
    super.initState();
    _stockfishService.start();
    previousFen = _controller.getFen();
  }

  void onMove() async {
    String currentFen = _controller.getFen();

    if (isCapture(previousFen, currentFen)) {
      applyBuffDebuff(); // ici pas besoin de la pièce pour l'instant
    }

    previousFen = currentFen; // mettre à jour pour la prochaine comparaison

    await Future.delayed(const Duration(milliseconds: 500));
    await _playStockfishMove();
  }

  bool isCapture(String oldFen, String newFen) {
    int oldCount = countPieces(oldFen);
    int newCount = countPieces(newFen);
    return newCount < oldCount;
  }

  int countPieces(String fen) {
    // Compte toutes les pièces
    return fen.split(' ').first.replaceAll(RegExp(r'[^rnbqkpRNBQKP]'), '').length;
  }

  void applyBuffDebuff() {
    setState(() {
      rotated = !rotated;
    });
  }

  Future<void> _playStockfishMove() async {
    final fen = _controller.getFen();
    final move = await _stockfishService.getBestMove(fen);

    if (move.length >= 4) {
      _controller.makeMove(from: move.substring(0, 2), to: move.substring(2, 4));
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
      appBar: AppBar(title: const Text('Chess Buffs')),
      body: Center(
        child: Transform.rotate(
          angle: rotated ? 3.14 : 0,
          child: ChessBoard(
            controller: _controller,
            onMove: onMove,
            boardColor: BoardColor.brown,
            boardOrientation: PlayerColor.white,
          ),
        ),
      ),
    );
  }
}
