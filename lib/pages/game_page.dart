import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import '../service/stockfish_service.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  ChessBoardController controller = ChessBoardController();
  final StockfishService stockfishService = StockfishService();

  @override
  void initState() {
    super.initState();
    stockfishService.start();

    stockfishService.outputStream.listen((response) {
      print('Réponse Stockfish : $response');
      // ici tu peux analyser les "bestmove" pour jouer automatiquement
    });
  }

  @override
  void dispose() {
    stockfishService.stop();
    super.dispose();
  }

  void _onPlayerMove() {
    String fen = controller.getFen();
    print('Envoi du FEN au moteur: $fen');

    stockfishService.sendCommand('position fen $fen');
    stockfishService.sendCommand('go depth 10'); // demande de réfléchir 10 coups
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Partie Fun')),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            ChessBoard(
              controller: controller,
              boardColor: BoardColor.brown,
              boardOrientation: PlayerColor.white,
              enableUserMoves: true,
              onMove: _onPlayerMove,
            ),
            SizedBox(height: 20),
            Text('Stockfish réfléchit !'),
          ],
        ),
      ),
    );
  }
}
