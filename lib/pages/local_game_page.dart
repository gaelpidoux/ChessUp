import 'package:flutter/material.dart' as mat;
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'dart:math';

class LocalGamePage extends mat.StatefulWidget {
  const LocalGamePage({super.key});

  @override
  mat.State<LocalGamePage> createState() => _LocalGamePageState();
}

class _LocalGamePageState extends mat.State<LocalGamePage> {
  final ChessBoardController _controller = ChessBoardController();
  double _rotationAngle = 0;

  @override
  mat.Widget build(mat.BuildContext context) {
    return mat.Scaffold(
      backgroundColor: const mat.Color(0xFF2E1B47),
      appBar: mat.AppBar(
        backgroundColor: const mat.Color(0xFF1E1433),
        title: const mat.Text("Partie locale (1v1)"),
      ),
      body: mat.Column(
        mainAxisAlignment: mat.MainAxisAlignment.center,
        children: [
          mat.Transform.rotate(
            angle: _rotationAngle,
            child: ChessBoard(
              controller: _controller,
              boardColor: BoardColor.brown,
              enableUserMoves: true,
              arrows: [],
            ),
          ),
          const mat.SizedBox(height: 20),
          mat.ElevatedButton(
            style: mat.ElevatedButton.styleFrom(
              backgroundColor: const mat.Color(0xFF553377),
              foregroundColor: mat.Colors.white,
              padding: const mat.EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              setState(() {
                _rotationAngle += pi; // rotation 180°
              });
            },
            child: const mat.Text("Tourner le plateau"),
          ),
        ],
      ),
    );
  }
}
