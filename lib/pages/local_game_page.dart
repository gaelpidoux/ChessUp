
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_chess_board/flutter_chess_board.dart';

class LocalGamePage extends StatefulWidget {
  const LocalGamePage({super.key});

  @override
  State<LocalGamePage> createState() => _LocalGamePageState();
}

class _LocalGamePageState extends State<LocalGamePage> {
  final ChessBoardController _controller = ChessBoardController();
  bool rotated = false;

  @override
  Widget build(mat.BuildContext context) {
    return mat.Scaffold(
      backgroundColor: mat.Color(0xFF2E1B47),
      appBar: mat.AppBar(
        backgroundColor: mat.Color(0xFF1E1433),
        title: const mat.Text('Duel Local', style: mat.TextStyle(color: mat.Colors.amber)),
        iconTheme: const mat.IconThemeData(color: mat.Colors.amber),
      ),
      body: mat.Column(
        mainAxisAlignment: mat.MainAxisAlignment.center,
        children: [
          ChessBoard(
            controller: _controller,
            boardColor: BoardColor.brown,
            arrows: [],
          ),
          const mat.SizedBox(height: 20),
          mat.ElevatedButton(
            onPressed: () => setState(() => rotated = !rotated),
            style: mat.ElevatedButton.styleFrom(backgroundColor: mat.Color(0xFF553377)),
            child: const mat.Text('Tourner le plateau', style: mat.TextStyle(color: mat.Colors.white)),
          )
        ],
      ),
    );
  }
}
